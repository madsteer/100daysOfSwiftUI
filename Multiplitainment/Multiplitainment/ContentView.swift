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
    @State private var multiplicationUpperBound = 2
    @State private var numberOfQuestionsToAsk = numberOfQuestionsChoicesStatic[0]
    @State private var factors = [Factor]()
    @State private var factorIndex = 0
    @State private var guess = 0
    @State private var answerTitle = ""
    @State private var answerMessage = ""
    
    
    private static let numberOfQuestionsChoicesStatic = [ 5, 10, 20 ]
    private let numberOfQuestionsChoices = numberOfQuestionsChoicesStatic
    var body: some View {
        if !hasGameStarted {
            NavigationStack {
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
        } else if factorIndex < factors.count {
            NavigationView {
                VStack {
                    Spacer()

                    Section("Current Problem") {
//                        Text("What is")
//                            .font(.title)
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
                .navigationTitle("Multiplitainment")
                .onSubmit { checkAnswer() }
            }
            .alert(answerTitle, isPresented: $showingResult) {
                Button("Continue", action: advanceQuestion)
            } message: {
                Text(answerMessage)
            }
        } else {
            NavigationView {
                List {
                    Section {
                        Text("How'd you do?")
                    }
                    
                    Section("Results") {
                        ForEach(factors, id: \.self) { factor in
                            Section("Problem") {
                                Text("\(factor.multicand) x \(factor.multiplier)")
                            }
                            
                            Section("Result") {
                                HStack {
                                    Text("Answer: \(factor.answer)")
                                    
                                    Spacer()
                                    
                                    Text("Guess: \(factor.guess)")
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Section {
                        Button("Play Again?") {
                            resetGame()
                        }
                    }
                }
                .navigationTitle("Multiplitainment")
            }
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
