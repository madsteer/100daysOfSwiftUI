//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Cory Steers on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(Font.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: min(geo.frame(in: .global).origin.y / fullView.frame(in: .global).maxY, 1.0), saturation: 1.0, brightness: 1.0))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(max(1 * geo.frame(in: .global).origin.y / 200.0, 0.5))
                            .scaleEffect(max(geo.frame(in: .global).origin.y / fullView.frame(in: .global).maxY * 2, 0.5))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
