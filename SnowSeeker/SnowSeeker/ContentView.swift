//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/24/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct ContentView: View {
//    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//            }
//            .padding()
        
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }

//        if sizeClass == .compact {
//            VStack {
//                UserView()
//            }
//        } else {
//            HStack {
//                UserView()
//            }
//        }

        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}

#Preview {
    ContentView()
}
