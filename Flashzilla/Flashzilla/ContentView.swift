//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
//                .onLongPressGesture(minimumDuration: 1) {
//                    print("Long pressed!")
//                } onPressingChanged: { inProgress in
//                    print("In progress: \(inProgress)")
//                }
        }
        .padding()
        .scaleEffect(finalAmount + currentAmount)
        .gesture(
            MagnificationGesture()
                .onChanged { amount in
                    print("executing on changed")
                    currentAmount = amount - 1
                }
                .onEnded { amount in
                    print("executing on ended")
                    finalAmount += currentAmount
                    currentAmount = 0
                }
        )

    }
}

#Preview {
    ContentView()
}
