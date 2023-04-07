//
//  ContentView.swift
//  Multiplitainment
//
//  Created by Cory Steers on 4/5/23.
//

import SwiftUI

struct Factor: Hashable {
    var multicand: Int
    var multiplier: Int
    var answer: Int
    var guess: Int
}

struct ContentView: View {
    @State private var hasGameStarted = false
    @State private var showingResult = false
    @State public var multiplicationUpperBound = 2
    @State public var numberOfQuestionsToAsk = numberOfQuestionsChoicesStatic[0]
    @State private var factors = [Factor]()
    @State private var factorIndex = 0
    @State private var guess = 0
    @State private var answerTitle = ""
    @State private var answerMessage = ""
    
    
    private static let numberOfQuestionsChoicesStatic = [ 5, 10, 20 ]
    private let numberOfQuestionsChoices = numberOfQuestionsChoicesStatic
    
    var body: some View {
        NavigationStack {
            Group {
                if !hasGameStarted {
                    SetUpGameView(
                            multiplicationUpperBound: $multiplicationUpperBound,
                            numberOfQuestionsToAsk: $numberOfQuestionsToAsk,
                            numberOfQuestionsChoices: numberOfQuestionsChoices,
                            startGame: { self.startGame() }
                        )
                }
                
                if hasGameStarted && factorIndex < factors.count {
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
                                
                                TextField("hi ", text: Binding(
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
                
                if hasGameStarted && factorIndex >= factors.count {
                    ResultsListView(
                      factors: factors,
                      resetGame: { self.resetGame() }
                    )
                }
            }
            .navigationTitle("Multiplitainment")
        }
    }

    
    func advanceQuestion() {
        factorIndex += 1
        guess = 0
    }
    
    func checkAnswer() {
        factors[factorIndex].guess = guess
        if guess == factors[factorIndex].answer {
            answerTitle = "Good Job!"
            answerMessage = "\(guess) is correct!"
        } else {
            answerTitle = "Not Quite"
            answerMessage = "Sorry, but the correct answer is \(factors[factorIndex].answer)"
        }
        showingResult = true
    }
    
    func startGame() {
        for _ in 0..<numberOfQuestionsToAsk {
            let factor = Factor(
                multicand: Int.random(in: 1...multiplicationUpperBound),
                multiplier: Int.random(in: 1...multiplicationUpperBound),
                answer: -1,
                guess: -1
            )
            factors.append(factor)
        }
        
        for index in 0..<factors.count {
            factors[index].answer = factors[index].multicand * factors[index].multiplier
        }
        
        hasGameStarted = true
    }
    
    func resetGame() {
        hasGameStarted = false
        factors = [Factor]()
        factorIndex = 0
        guess = 0
        multiplicationUpperBound = 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
