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
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundStyle(.tint)
        //            Text("Live long and prosper!")
        //                .frame(width: 300, height: 300, alignment: .topLeading)
        //                .offset(x: 50, y: 50)
        //        }
        //        .padding()
        
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@madsteer")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("apollo13")
                    .resizable()
                    .frame(width: 64, height: 64)
                
            }
            
            VStack {
                Text("Full name:")
                Text("CORY STEERS")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}
