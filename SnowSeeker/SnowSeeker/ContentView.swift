//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/24/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//            }
//            .padding()
            
        NavigationView {
            NavigationLink {
                Text("New Secondary")
            } label: {
                Text("Hellow, world!")
            }
            .navigationTitle("Primary")
            
            Text("Secondary")
            
            
            Text("Tertiary")
        }
    }
}

#Preview {
    ContentView()
}
