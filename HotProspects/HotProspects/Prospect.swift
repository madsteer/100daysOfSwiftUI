//
//  Prospect.swift
//  HotProspects
//
//  Created by Cory Steers on 9/20/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let saveContactsFile = FileManager.documentsDirectory.appendingPathComponent("SavedContacts")
    
    init() {
        do {
            let data = try Data(contentsOf: saveContactsFile)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print(error.localizedDescription)
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: saveContactsFile, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
