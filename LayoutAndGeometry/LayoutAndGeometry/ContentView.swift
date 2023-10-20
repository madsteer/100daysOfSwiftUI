//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Cory Steers on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .padding(20)
                .background(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
