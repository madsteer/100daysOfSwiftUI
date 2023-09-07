//
//  WhoWasThatApp.swift
//  WhoWasThat
//
//  Created by Cory Steers on 8/31/23.
//

import SwiftUI

@main
struct WhoWasThatApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
