//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Cory Steers on 10/19/23.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("top")
            InnerView()
                .background(.green)
            Text("bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("left")
            
            GeometryReader { geo in
                    Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center is \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Local center is \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        print("Custom center is \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            
            Text("right")
        }
    }
}

struct ContentView: View {
    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                VStack {
//                    Image(systemName: "globe")
//                    Text("Live long and prosper!")
//                }
//                .padding()
//                .frame(width: geo.size.width * 0.9)
//                .background(.red)
//            }
//            .background(.green)
//            
//            Text("more text")
//                .background(.blue)
//        }
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    ContentView()
}
