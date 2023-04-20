//
//  ContentView.swift
//  Moodshot
//
//  Created by Cory Steers on 4/20/23.
//

import SwiftUI

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detailed \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
