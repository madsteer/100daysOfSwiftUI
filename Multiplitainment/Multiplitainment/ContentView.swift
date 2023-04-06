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
}

struct ContentView: View {
    @State private var hasGameStarted = false
    @State private var multiplicationUpperBound = 2
    @State private var numberOfQuestionsToAsk = numberOfQuestionsChoicesStatic[0]
    @State private var factors = [Factor]()
    
    
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
        } else {
            NavigationStack {
                List {
                    HStack {
                        Spacer()
                        
                        Button("Reset") {
                            hasGameStarted = false
                        }
                    }
                    
                    Section {
                        Text("Here's what your questions would be")
                    }
                    .font(.title)
                    
                    Section {
                        ForEach(factors, id: \.self) { factor in
                            Text("What is \(factor.multicand) x \(factor.multiplier) ? (\(factor.answer))")
                        }
                    }
                }
                .navigationTitle("Multiplitainment")
            }
        }
    }
    
    func startGame() {
        for _ in 0..<numberOfQuestionsToAsk {
            let factor = Factor(
                multicand: Int.random(in: 1...multiplicationUpperBound),
                multiplier: Int.random(in: 1...multiplicationUpperBound),
                answer: -1
            )
            factors.append(factor)
        }
        
        for index in 0..<factors.count {
            factors[index].answer = factors[index].multicand * factors[index].multiplier
        }
//        ForEach(factors, id: \.self) { factor in
//            factor.answer = $0.multicand * $0.multiplier
//        }
        
        hasGameStarted = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
