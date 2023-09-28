//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
        
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle()) // makes whole Vstack tappable including Spacer area
        .onTapGesture {
            print("Vstack tapped!")
        }
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//            
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle()) // whole rectangle is circle tapped
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                .allowsHitTesting(false) // whole rectangle is rectangle tapped
//        }
    }
}

#Preview {
    ContentView()
}
