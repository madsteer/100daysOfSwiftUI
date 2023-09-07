//
//  AddContactView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/5/23.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var contact: Contact?
    
    @State private var inputImage: UIImage?
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showingImagePicker = false
    @State private var image: Image?
        
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
            }
            .toolbar {
                Button("Save") {
                    if let inputImage = inputImage,
                       let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                        contact = Contact(id: UUID(),
                                              firstName: firstName,
                                              lastName: lastName,
                                              picture: jpegData
                        )
                    }
                    dismiss()
                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
        .onAppear {
            showingImagePicker = true
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
                    
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
