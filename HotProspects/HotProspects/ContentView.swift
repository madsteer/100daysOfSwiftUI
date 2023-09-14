//
//  ContentView.swift
//  HotProspects
//
//  Created by Cory Steers on 9/13/23.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
//    @Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var updater = DelayedUpdater()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Value is \(updater.value)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
