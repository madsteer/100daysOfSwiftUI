//
//  AddContactView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/5/23.
//

import MapKit
import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var contact: Contact?
    
    @State private var inputImage: UIImage?
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var location: CLLocationCoordinate2D?
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    let locationFetcher = LocationFetcher()
        
    var body: some View {
        NavigationView {
            Form {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tab to select a new face")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                TextField("First Name", text: $firstName)
                
                TextField("Last Name", text: $lastName)
                
                Section {
                    if location != nil {
                        ZStack {
                            Map(coordinateRegion: $mapRegion)
                            
                            Circle()
                                .fill(.blue)
                                .opacity(0.3)
                                .frame(width: 32, height:32)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                    } else {
                        Button("Add Current Location") {
                            if let location = self.locationFetcher.lastKnownLocation {
                                self.location = location
                            }
                        }
                    }
                }
            }
            .toolbar {
                Button("Save") {
                    if let inputImage = inputImage,
                       let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                        contact = Contact(id: UUID(),
                                          firstName: firstName,
                                          lastName: lastName,
                                          picture: jpegData,
                                          location: location
                        )
                    }
                    dismiss()
                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .onChange(of: location) { _ in
                if let location = location {
                    mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
        .onAppear {
            self.locationFetcher.start()
            showingImagePicker = true
        }
    }
    
    func loadImage() {
        print("loadImage 1")
        guard let inputImage = inputImage else { return }
        
        print("loadImage 2")
        
        image = Image(uiImage: inputImage)
        
        print("loadImage 3")
                    
        return
    }

}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        @State var contact: Contact?
        
        NavigationView {
            AddContactView(contact: $contact)
        }
        .navigationTitle("Add Contact")
    }
}
