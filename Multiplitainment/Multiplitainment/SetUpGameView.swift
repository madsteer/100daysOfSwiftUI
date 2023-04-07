//
//  SetUpGameView.swift
//  Multiplitainment
//
//  Created by Cory Steers on 4/7/23.
//

import SwiftUI

struct SetUpGameView: View {
    @Binding public var multiplicationUpperBound: Int
    @Binding public var numberOfQuestionsToAsk: Int
    var numberOfQuestionsChoices: [Int]
    
    var startGame: () -> Void
    
    var body: some View {
        Form {
            Section {
                Stepper("From 2 - \(multiplicationUpperBound)", value: $multiplicationUpperBound, in: 2...12, step: 1)
            } header: {
                Text("Desired maximum Multipliers")
            }
            
            Section {
                Picker("\(numberOfQuestionsToAsk) Questions", selection: $numberOfQuestionsToAsk) {
                    ForEach(numberOfQuestionsChoices, id: \.self) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("How many questions do you want to be asked?")
            }
            .navigationTitle("Multiplitainment")
            
            Section {
                HStack {
                    Text("Ready to start?")
                    
                    Spacer()
                    
                    Button("Play") {
                        startGame()
                    }
                }
            }
        }
    }
}
