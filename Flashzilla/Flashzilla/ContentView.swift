//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onLongPressGesture(minimumDuration: 1) {
                    print("Long pressed!")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
