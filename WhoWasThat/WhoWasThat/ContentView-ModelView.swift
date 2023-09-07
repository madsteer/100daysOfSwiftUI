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
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var showingAddContactScreen = false
        
        @Published private(set) var contacts: [Contact]
        
        @Published var isUnlocked = true
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
    }
}
