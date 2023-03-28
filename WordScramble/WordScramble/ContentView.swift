//
//  ContentView.swift
//  WordScramble
//
//  Created by Cory Steers on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0..<5) {
            Text("Dynamic row \($0 + 1)")
//            Section("Section 1") {
//                Text("Static Row 1")
//                Text("Static Row 2")
//            }
//
//            Section("Section 2") {
//                ForEach(0..<5) {
//                    Text("Dynamic row \($0+1)")
//                }
//            }
//
//            Section("Section 3") {
//                Text("Hello, world!")
//                Text("Hello, world!")
//                Text("Hello, world!")
//            }
        }
        .listStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
