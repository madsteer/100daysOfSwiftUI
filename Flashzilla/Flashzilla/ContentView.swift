//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
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
        .rotationEffect(finalAmount + currentAmount)
        .gesture(
            RotationGesture()
                .onChanged { angle in
                    currentAmount = angle
                }
                .onEnded { angle in
                    finalAmount += currentAmount
                    currentAmount = .zero
                }
        )

    }
}

#Preview {
    ContentView()
}
