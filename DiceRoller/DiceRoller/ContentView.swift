//
//  ContentView.swift
//  DiceRoller
//
//  Created by Cory Steers on 10/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    let rollTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Number of dice in roll?")
                        Spacer()
                        TextField("02", value: $viewModel.numDice, formatter: viewModel.diceFormatter)
                            .multilineTextAlignment(.trailing)
                            .fixedSize()
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    .font(.title)
                    
                    HStack {
                        Text("How many sided die?")
                        Spacer()
                        TextField("06", value: $viewModel.numSides, formatter: viewModel.diceFormatter)
                            .multilineTextAlignment(.trailing)
                            .fixedSize()
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)
                    .font(.title)
                    
                    HStack {
                        ForEach(0..<viewModel.numDice, id: \.self) { index in
                            Text("\(index < viewModel.rollresults.count ? viewModel.rollresults[index] : 0)")
                                .font(.largeTitle)
                                .padding(5)
                                .border(.secondary, width: 3)
                        }
                    }
                    .scaledToFill()
                    
                    Button {
                        viewModel.isDiceRolling = true
                    } label: {
                        Text("Roll Dice")
                            .font(.largeTitle)
                    }
                    .padding()
                    .onTapGesture(perform: rollDiceTapticGesture)
                }
                
                List {
                    ForEach(viewModel.rolls, id: \.self) { roll in
                        NavigationLink {
                            RollView(rolls: $viewModel.rolls, roll: roll)
                        } label: {
                            Text("\(roll.dice.count) dice with \(roll.dice[0].numSides) sides, result: \(roll.total)")
                        }
                    }
                    .onDelete(perform: removeARoll)
                }
            }
            .navigationTitle("Dice Roller")
            .onReceive(rollTimer) { time in
                guard viewModel.isDiceRolling else { return }
                
                viewModel.diceRollVisualizer()
                if viewModel.diceRollTimeRemaining <= 0 {
                    viewModel.isDiceRolling = false
                    viewModel.rollDice()
                }
                
            }
        }
        .onReceive(rollTimer) { time in
            guard viewModel.isDiceRolling else { return }
            if viewModel.diceRollTimeRemaining > 0 {
                viewModel.diceRollTimeRemaining -= 1
            }
        }
    }
    
    func removeARoll(at offsets: IndexSet) {
        viewModel.removeARoll(at: offsets)
    }
    
    func rollDiceTapticGesture() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    ContentView()
}
