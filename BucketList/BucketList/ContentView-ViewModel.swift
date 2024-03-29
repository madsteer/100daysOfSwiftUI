//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Cory Steers on 8/29/23.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var isUnlockedFailedAlert = false
        @Published var isUnlockedFailedMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let touchIdReason = "Would you like to use Biometrics to log in?"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: touchIdReason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        print("Biometric authentication failed: \(authenticationError?.localizedDescription ?? "<no error description>")")
                        Task { @MainActor in
                            self.isUnlockedFailedMessage = "Touch ID/Face ID didn't work"
                            self.isUnlockedFailedAlert = true
                        }
                    }
                }
            } else {
                self.isUnlockedFailedMessage = "Biometricd authentication not allowed for this app.  This can be fixed in iOS settings"
                print("Biometric authentication failed: \(error?.localizedDescription ?? "<no error description>")")
                self.isUnlockedFailedAlert = true
            }
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
    }
}
