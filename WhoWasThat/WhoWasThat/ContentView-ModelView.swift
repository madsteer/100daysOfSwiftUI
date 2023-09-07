//
//  ContentView-ModelView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/1/23.
//

import CoreImage
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Environment(\.managedObjectContext) var moc
        @FetchRequest(sortDescriptors: [SortDescriptor(\.lastName)]) var contacts: FetchedResults<Contact>

        @Published var image: Image?
        @Published var inputImage: UIImage?
//        @Published var showingImagePicker = false
        @Published var showingAddContactScreen = false
        
        @Published var persons: [Person] = [Person]()
//        @Published var contacts: [Contact]
        @Published var contactImages: [UUID: UIImage] = [:]
        
        @Published var isUnlocked = true
        @Published var isUnlockedFailedAlert = false
        @Published var isUnlockedFailedMessage = ""
        
        let context = CIContext()
        let saveContactsFile = FileManager.documentsDirectory.appendingPathComponent("SavedContacts")
        let savePicturesFolder = FileManager.documentsDirectory
        
//        init() {
//            do {
//                let data = try Data(contentsOf: saveContactsFile)
//                contacts = try JSONDecoder().decode([Contact].self, from: data)
//            } catch {
//                print(error.localizedDescription)
//                contacts = []
//
//            }
            
//            contacts.forEach { contact in
//                if let picture = getPicture(from: savePicturesFolder.appendingPathComponent(contact.wrappedPictureFilename)) {
//                    let person = Person(contact: contact, picture: picture)
//                    persons.append(person)
//                }
//            }
//
//            updateContacts()
//        }
        
        func populatePersons() {
            print("number of saved contacts: \(contacts.count)")
            var newPersons = [Person]()
            contacts.forEach { contact in
                if let picture = getPicture(from: savePicturesFolder.appendingPathComponent(contact.wrappedPictureFilename)) {
                    let person = Person(contact: contact, picture: picture)
                    newPersons.append(person)
                }
            }
            self._persons = Published(wrappedValue: newPersons)
        }
        
//        func updateContacts() {
//            contacts.forEach { contact in
//                if let picture = getPicture(from: savePicturesFolder.appendingPathComponent(contact.wrappedPictureFilename)) {
//                    contactImages[contact.id] = picture
//                } else {
//                    print("for some reason contact \(contact.firstName) \(contact.lastName) has no contact picture at \(contact.pictureFilename) near \(saveContactsFile).  Not displaying him")
//                    if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
//                        contacts.remove(at: index)
//                    }
//                }
//            }
//        }

        func loadImage() {
            guard let inputImage = inputImage else { return }
            
            image = Image(uiImage: inputImage)
                        
            return
        }
        
        func getPicture(from url: URL) -> UIImage? {
            
            do {
                let jpegData = try Data(contentsOf: url)
                return UIImage(data: jpegData)
            } catch {
                print("error trying to get picture at \(url.absoluteString): \(error.localizedDescription)")
            }
            
            return nil
        }
        
//        func addContact(_ contact: Contact) {
//            var newContaccts = contacts
//            newContaccts.append(contact)
//            _contacts = Published(initialValue: newContaccts)
////            contacts.append(contact)
//
//            save(contact: contact)
//        }

//        func save(contact: Contact) {
//            if let inputImage = inputImage, let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
//                do {
//                    try jpegData.write(to: savePicturesFolder.appendingPathComponent(contact.pictureFilename), options: [.atomicWrite, .completeFileProtection])
//
//                    let data = try JSONEncoder().encode(contacts)
//                    try data.write(to: saveContactsFile, options: [.atomicWrite, .completeFileProtection])
//                } catch {
//                    print("Unable to save one of contact photo or contact data: \(error.localizedDescription)")
//                }
//
//                self.inputImage = nil
//            }
//        }
    }
}
