//
//  ContentView.swift
//  Moodshot
//
//  Created by Cory Steers on 4/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            
        Image("aldrin")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width * 0.8)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
