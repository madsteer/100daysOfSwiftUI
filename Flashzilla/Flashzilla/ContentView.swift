//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
    }
}

#Preview {
    ContentView()
}
