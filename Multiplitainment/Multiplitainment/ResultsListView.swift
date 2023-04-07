//
//  ResultsListView.swift
//  Multiplitainment
//
//  Created by Cory Steers on 4/7/23.
//

import SwiftUI


struct ResultsListView: View {
    var factors: [Factor]
    var resetGame: () -> Void
    
    var body: some View {
        List {
            Section("Results") {
                Text("How'd you do?")
            }
            
            ForEach(factors, id: \.self) { factor in
                Section {
                    Text("Problem: \(factor.multicand) x \(factor.multiplier)")
                    
                    HStack {
                        Text("Answer: \(factor.answer)")
                        
                        Spacer()
                        
                        Text("Guess: \(factor.guess)")
                    }
                }
            }
            
            Section {
                Button("Play Again?") {
                    resetGame()
                }
            }
        }
    }
}
