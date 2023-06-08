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
        
        let rectangleX: CGFloat = rect.midX - (rect.midX / 4)
        let rectangleY: CGFloat =  rect.midY / 2
        let rectangleWidth = rect.midX + (rect.midX / 4) - rectangleX
        let rectangleHeight = rect.midY + (rect.midY / 4) - rectangleY

        var path = Path()
        
        path.move(to: arrowTip)
        path.addLine(to: arrowRightTip)
        path.addLine(to: arrowLeftTip)
        path.addLine(to: arrowTip)
        
        let cgRect: CGRect = CGRect(
            x: rectangleX,
            y: rectangleY,
            width: rectangleWidth,
            height: rectangleHeight
        )
        
        path.addRect(cgRect)
        
        return path
    }
}


struct ContentView: View {
    @State private var lineWidth: CGFloat = 10.0
   
    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    var body: some View {
        Arrow()
            .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 600)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 3)) {
                    lineWidth = Double.random(in: 1...20)
                    print("I'm here.")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
