//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/26/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String> = []
    private let saveKey = "Favorites"
    
    private let savedFavoritesFile = FileManager.documentsDirectory.appendingPathComponent("SavedFavorites")
    
    init() {
        loadData()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        
        save()
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savedFavoritesFile)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            print(error.localizedDescription)
            resorts = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savedFavoritesFile, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save the favorited resorts: \(error.localizedDescription)")
        }
    }
}
