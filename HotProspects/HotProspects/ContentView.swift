//
//  ContentView.swift
//  HotProspects
//
//  Created by Cory Steers on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
        
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .onTapGesture {
                    selectedTab = "One"
                }
                .tag("Two")
        }
    }
}

#Preview {
    ContentView()
}
