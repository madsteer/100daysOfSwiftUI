//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ContentView: View {
    @Environment(\..accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .scaleEffect(scale)
        .onTapGesture {
//            if reduceMotion {
//                scale += 1.5
//            } else {
//                withAnimation {
//                    scale *= 1.5
//                }
//            }
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
