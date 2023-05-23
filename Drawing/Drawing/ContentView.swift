//
//  ContentView.swift
//  Drawing
//
//  Created by Cory Steers on 5/16/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.3), lineWidth: 20)
            .frame(width: 300, height: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
