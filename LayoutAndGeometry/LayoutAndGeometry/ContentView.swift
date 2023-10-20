//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Cory Steers on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Live long and prosper!")
//                .frame(width: 300, height: 300, alignment: .topLeading)
//                .offset(x: 50, y: 50)
//        }
//        .padding()
        
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
        VStack(alignment: .leading) {
//            Text("Hello, world!")
//                .alignmentGuide(.leading) { d in
//                    d[.trailing]
//                }
//            Text("This is a longer line of text")
            ForEach(0..<10) { position in
                    Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                            Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
