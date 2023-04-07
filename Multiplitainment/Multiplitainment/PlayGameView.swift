//
//  PlayGameView.swift
//  Multiplitainment
//
//  Created by Cory Steers on 4/7/23.
//

import SwiftUI

struct PlayGameView: View {
    @Binding public var showingResult: Bool
    var answerMessage: String
    var answerTitle: String
    var factors: [Factor]
    var factorIndex: Int
    @Binding public var guess: Int
    
    var advanceQuestion: () -> Void
    var checkAnswer: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Section("Current Problem") {
                Text("What is \(factors[factorIndex].multicand) X \(factors[factorIndex].multiplier)?")
                    .font(.title)
            }
            .font(.largeTitle)
            
            Spacer()
            
            Section {
                HStack {
                    Text("Answer: ")
                        .font(.title)
                    
                    TextField("", text: Binding(
                        get: { String(guess) },
                        set: { guess = Int($0) ?? 0}
                    ))
                    .keyboardType(.numberPad)
                    .font(.title)
                }
            }
            
            Spacer()
        }
        .onSubmit { checkAnswer() }
        .alert(answerTitle, isPresented: $showingResult) {
            Button("Continue", action: advanceQuestion)
        } message: {
            Text(answerMessage)
        }
    }
}


