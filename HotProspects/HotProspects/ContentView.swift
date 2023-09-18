//
//  ContentView.swift
//  HotProspects
//
//  Created by Cory Steers on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("armstrong")
            .interpolation(.none) // this would work better with a crappy really small picture
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
