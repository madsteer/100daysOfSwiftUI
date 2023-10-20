//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Cory Steers on 10/19/23.
//

import SwiftUI

extension VerticalAlignment {
//    struct MidAccountAndName: AlignmentID {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
                VStack {
                    Image(systemName: "globe")
                    Text("Live long and prosper!")
                }
                .padding()
//                .background(.red)
//                .position(x: 100, y: 100)
                .offset(x: 100, y: 100)
                .background(.red)
    }
}

#Preview {
    ContentView()
}
