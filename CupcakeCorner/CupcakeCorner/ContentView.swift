//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Cory Steers on 6/14/23.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) // works
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) // works
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
//            .resizable() // won't compile
//            .frame(width: 200, height: 200) // won't have any affect
        
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
