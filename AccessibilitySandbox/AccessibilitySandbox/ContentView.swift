//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Cory Steers on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
        
        Image(decorative: "character")
            .accessibilityHidden(true)
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
//        .accessibilityElement(children: .combine)
        .accessibilityElement(children: .ignore) // or just .accessibilityElement() as ignore is the default
        .accessibilityLabel("Your score is 1000")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
