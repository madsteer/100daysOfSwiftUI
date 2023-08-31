//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Cory Steers on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Text("Value: \(value)")
            
            Spacer()
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decremenet") {
                value -= 1
            }
            Spacer()
            Spacer()
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
