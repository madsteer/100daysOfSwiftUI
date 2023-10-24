//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//            }
//            .padding()
        
        NavigationView {
//            Text("Searching for \(searchText)")
//                .searchable(text: $searchText, prompt: "Look for something")
//                .navigationTitle("Searching")
            
            List(filteredNames, id: \.self) { name in
                Text(name)
                    .searchable(text: $searchText, prompt: "Look for something")
                    .navigationTitle("Searching")
            }
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

#Preview {
    ContentView()
}
