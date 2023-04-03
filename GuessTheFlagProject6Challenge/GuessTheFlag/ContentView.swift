//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Cory Steers on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var resetGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var finalScoreTitle = ""
    @State private var numberOfQuestions = 0
    @State private var countries = [ "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var rotationAnimationAmounts = [ 0.0, 0.0, 0.0 ]
    @State private var buttonOpacity = [ 1.0, 1.0, 1.0 ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.1, green: 0.2, blue: 0.45),
                Color(red: 0.76, green: 0.15, blue: 0.26)
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                rotationAnimationAmounts[number] += 360
                                buttonOpacity.indices.forEach { index in
                                    if (index != number) {
                                        buttonOpacity[index] = 0.25
                                    }
                                }
                            }
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(radius: 5)
                        }
                        .opacity(buttonOpacity[number])
                        .rotation3DEffect(.degrees(rotationAnimationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(isPresented: $resetGame) {
            Alert(
                title: Text(finalScoreTitle),
                message: Text("Would you like to start a new game?"),
                primaryButton: .default(Text("Yes")) {
                    startNewGame()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that's the flag for \(countries[number])"
        }
        

        numberOfQuestions += 1
        if (numberOfQuestions < 8) {
            showingScore = true
        } else {
            finalScoreTitle = "\(scoreTitle)\nYour final score is \(score) out of \(numberOfQuestions)"
            resetGame = true
        }
    }
    
    func startNewGame() {
        score = 0
        numberOfQuestions = 0
        askQuestion()
    }
    
    func askQuestion() {
        buttonOpacity.indices.forEach { index in
            buttonOpacity[index] = 1.0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
