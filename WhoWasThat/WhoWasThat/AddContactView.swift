//
//  AddContactView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/5/23.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @Binding var persons: [Person]
    
    @State private var inputImage: UIImage?
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var url: URL?
    @State private var showingImagePicker = false
    @State private var image: Image?
    
    var successHandler: (() -> Void)?
    let imageSaver = ImageSaver()
    
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
                    if let inputImage = inputImage {
                        let id = UUID()
                        let contact = Contact(context: moc)
                        contact.id = id
                        contact.firstName = firstName
                        contact.lastName = lastName
                        contact.pictureFilename = id.uuidString
                        imageSaver.successHandler = {
                            if moc.hasChanges {
                                do {
                                    try moc.save()
                                } catch {
                                    print("moc save failed: \(error.localizedDescription)")
                                }
//                                try? moc.save()
                                print("did I save?")
                            }
                            persons.append(Person(contact: contact, picture: inputImage))
                            print("Picture for \(firstName) \(lastName) saved!")
                        }
                        imageSaver.errorHandler = {
                            print("Unable to save one of contact photo: \($0.localizedDescription)")
                        }
                        imageSaver.writePhotoToDisk(inputImage, fileName: id.uuidString)
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
        @State var persons = [Person]()
        
        NavigationView {
            AddContactView(persons: $persons)
        }
        .navigationTitle("Add Contact")
    }
}
