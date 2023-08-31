//
//  ContentView.swift
//  Moonshot
//
//  Created by Cory Steers on 4/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var gridView = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
        
    var body: some View {
        NavigationView {
            ScrollView {
                if gridView {
                    MainGridView(astronauts: astronauts, missions: missions)
                } else {
                    MainListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Toggle View", action: toggleView)
            }
        }
    }
    
    func toggleView() {
        gridView.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
