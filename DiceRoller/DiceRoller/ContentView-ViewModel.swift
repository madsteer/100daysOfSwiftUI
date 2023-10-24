//
//  ContentView+ViewModel.swift
//  DiceRoller
//
//  Created by Cory Steers on 10/20/23.
//

import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var rolls = [Roll]()
        @Published var numDice = 2
        @Published var numSides = 6
        @Published private(set) var rollresults = [Int]()

        @Published var isDiceRolling = false
        @Published var diceRollTimeRemaining = 100

        
        let diceFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
        
        private let savedRollsFile = FileManager.documentsDirectory.appendingPathComponent("SavedRolls")

        init() {
            loadData()
        }
        
        func rollDice() {
            diceRollTimeRemaining = 100
            var dice = [Die]()
            rollresults = [Int]()
            for _ in 0..<numDice {
                let result = Int.random(in: 1...numSides)
                let die = Die(numSides: numSides, result: result)
                dice.append(die)
                rollresults.append(result)
            }
            
            let roll = Roll(id: UUID(), dice: dice, total: dice.reduce(0, {$0 + ($1.result)}))
            rolls.insert(roll, at: 0)
            saveData()
        }
        
        func diceRollVisualizer() {
            print("am I getting into diceRollVisualizer? \(rollresults.count) ")
            if rollresults.count >= numDice {
                for (index, _) in rollresults.enumerated() {
                    print("updating value for rollResults \(index) from \(rollresults[index])")
                    rollresults[index] = Int.random(in: 1...numSides)
                }
            } else {
                rollresults.append(Int.random(in: 1...numSides))
            }
        }
        
        func removeARoll(at offsets: IndexSet) {
            rolls.remove(atOffsets: offsets)
            
            saveData()
        }
        
        func loadData() {
            do {
                let data = try Data(contentsOf: savedRollsFile)
                rolls = try JSONDecoder().decode([Roll].self, from: data)
            } catch {
                print(error.localizedDescription)
                rolls = []
            }
        }
        
        func saveData() {
            do {
                let data = try JSONEncoder().encode(rolls)
                try data.write(to: savedRollsFile, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save the new card: \(error.localizedDescription)")
            }
        }
    }
}
