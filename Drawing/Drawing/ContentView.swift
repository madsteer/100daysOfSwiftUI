//
//  ContentView.swift
//  Drawing
//
//  Created by Cory Steers on 5/16/23.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        let arrowTip = CGPoint(x: rect.midX, y: rect.minY)
        let arrowRightTip = CGPoint(
            x: rect.maxX - (rect.midX / 2),
            y: rect.midY - (rect.midY / 2)
        )
        let arrowLeftTip = CGPoint(x: rect.midX / 2, y: rect.midY / 2)
        
        let firstRectangleCorner = CGPoint(
            x: rect.midX - (rect.midX / 4),
            y: rect.midY / 2
        )
        let secondRectangleCorner = CGPoint(
            x: rect.midX + (rect.midX / 4),
            y: rect.midY / 2
        )
        let thirdRectangleCorner = CGPoint(
            x: rect.midX + (rect.midX / 4),
            y: rect.midY + (rect.midY / 4)
            )
        let fourthRectangleCorner = CGPoint(
            x: rect.midX - (rect.midX / 4),
            y: rect.midY + (rect.midY / 4)
            )

        var path = Path()
        
        path.move(to: arrowTip)
        path.addLine(to: arrowRightTip)
        path.addLine(to: arrowLeftTip)
        path.addLine(to: arrowTip)
        
        path.move(to: firstRectangleCorner)
        path.addLine(to: secondRectangleCorner)
        path.addLine(to: thirdRectangleCorner)
        path.addLine(to: fourthRectangleCorner)

        return path
    }
}


struct ContentView: View {
   
    var body: some View {
        Arrow()
            .frame(width: 300, height: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
