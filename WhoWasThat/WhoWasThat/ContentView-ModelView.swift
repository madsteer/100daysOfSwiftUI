//
//  ContentView-ModelView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/1/23.
//

import CoreImage
import LocalAuthentication
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var showingAddContactScreen = false
        
        @Published private(set) var contacts: [Contact]
        
        @Published var isUnlocked = false
        @Published var isUnlockedFailedAlert = false
        @Published var isUnlockedFailedMessage = ""
        
        let context = CIContext()
        let saveContactsFile = FileManager.documentsDirectory.appendingPathComponent("SavedContacts")
        
        init() {
            do {
                let data = try Data(contentsOf: saveContactsFile)
                contacts = try JSONDecoder().decode([Contact].self, from: data)
            } catch {
                print(error.localizedDescription)
                contacts = []

            }
        }

        func save(_ contact: Contact) {
            contacts.append(contact)
            do {
                let data = try JSONEncoder().encode(contacts)
                try data.write(to: saveContactsFile, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save one of contact photo or contact data: \(error.localizedDescription)")
            }
            
            self.inputImage = nil
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
        
    }
}
