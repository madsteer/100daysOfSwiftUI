//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cory Steers on 2/16/23.
//

import SwiftUI

struct ShotButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(.primary, lineWidth: 2))
            .background(Color(red: 0.6, green: 0.4, blue: 0.2, opacity: 0.5))
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

extension View {
    func shotButtonStyle() -> some View {
        modifier(ShotButtonModifier())
    }
}
//struct ShotButton: View {
//    var shot: Shot
//    var win: Bool
//
//    var body: some View {
//        Button {
//            shotTapped(shot) // can't get this to work
//        } label: {
//            Text(shot.emoji)
//                .padding(5)
//                .font(.system(size: 40))
//        }
//        .shotButtonStyle()
//    }
//}

struct ContentView: View {
    @State private var shot: Shot
    @State private var win = Bool.random()
    @State private var score = 0
    @State private var showingResult = false
    @State private var resetGame = false
    @State private var resultText = ""
    @State private var finalScoreTitle = ""
    @State private var numberofGuesses = 0
        
    init() {
        shot = returnRandomShot()
    }
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.largeTitle.bold())
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("\(Shot.rock.name):")
                    
                    Text(Shot.rock.emoji)
                }
                HStack {
                    Text("\(Shot.paper.name):")
                    
                    Text(Shot.paper.emoji)
                }
                HStack {
                    Text("\(Shot.scissors.name):")
                    
                    Text(Shot.scissors.emoji)
                }
            }
            .font(.title)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(.primary, lineWidth: 2))
            .background(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.5))
            
            Spacer()
            
            HStack {
                Text("\"I\" Choose: ")
                
                Text(shot.emoji)
            }
            .padding()
            .font(.title)
            
            Text("Which choice \(win ? "allows  you to win" : "causes you to lose")?")
                .padding()
                .font(.title2)
            
            HStack {
                Button {
                    shotTapped(.rock)
                } label: {
                    Text(Shot.rock.emoji)
                        .padding(5)
                        .font(.system(size: 40))
                }
                .shotButtonStyle()
                
                Button {
                    shotTapped(.paper)
                } label: {
                    Text(Shot.paper.emoji)
                        .padding(5)
                        .font(.system(size: 40))
                }
                .shotButtonStyle()

                Button {
                    shotTapped(.scissors)
                } label: {
                    Text(Shot.scissors.emoji)
                        .padding(5)
                        .font(.system(size: 40))
                }
                .shotButtonStyle()
            }
            
            Spacer()
        }
        .padding()
        .alert(resultText, isPresented: $showingResult) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(isPresented: $resetGame) {
            Alert(title: Text(finalScoreTitle),
                  message: Text("Would you like to start a new game?"),
                  primaryButton: .default(Text("Yes")) {
                startNewGame()
            },
                  secondaryButton: .cancel()
            )
        }
    }

    func shotTapped(_ attempt: Shot) {
        var wonRound: Bool
        var answer = attempt
        
        switch attempt {
        case .rock:
            if win && shot == .scissors {
                wonRound = true
            } else if shot == .paper {
                wonRound = true
            } else {
                wonRound = false
                answer = win ? .scissors : .paper
            }
        case .paper:
            if win && shot == .rock {
                wonRound = true
            } else if shot == .scissors {
                wonRound = true
            } else {
                wonRound = false
                answer = win ? .rock : .scissors
            }
        case .scissors:
            if win && shot == .paper {
                wonRound = true
            } else if shot == .rock {
                wonRound = true
            }else {
                wonRound = false
                answer = win ? .paper : .rock
            }
        }
        
        if wonRound {
            resultText = "Good job!"
            score += 1
        } else {
            resultText = "Not Quite.  You wanted \(answer.emoji)."
        }

        numberofGuesses += 1
        if numberofGuesses < 8 {
            showingResult = true
        } else {
            finalScoreTitle = "\(resultText)\nYour final score is \(score) out of \(numberofGuesses)"
            resetGame = true
        }
    }

    func askQuestion() {
        shot = returnRandomShot()
        win = Bool.random()
    }
    
    func startNewGame() {
        score = 0
        numberofGuesses = 0
        askQuestion()
    }
}

enum Shot: CaseIterable {
    case rock
    case paper
    case scissors
    
    var name: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
    
    var emoji: String {
        switch self {
        case .rock:
            return "💎"
        case .paper:
            return "📃"
        case .scissors:
            return "✂️"
        }
    }
}

func returnRandomShot() -> Shot {
    let shotsArray = Shot.allCases.map { $0 }
    return shotsArray[Int.random(in: 0..<shotsArray.count)]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
