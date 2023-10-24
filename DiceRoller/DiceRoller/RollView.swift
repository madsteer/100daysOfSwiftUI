//
//  RollView.swift
//  DiceRoller
//
//  Created by Cory Steers on 10/23/23.
//

import SwiftUI

struct RollView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var rolls: [Roll]
    let roll: Roll
    
    var body: some View {
        List {
            ForEach(0..<roll.dice.count, id: \.self) { index in
                Text("\(roll.dice[index].numSides) sided die resulted in a \(roll.dice[index].result)")
            }
            
            Section {
                Button {
                    deleteRoll()
                } label: {
                    Text("Delete this roll")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Roll")
    }
    
    func deleteRoll() {
        if let index = rolls.firstIndex(of: roll) {
            print("got here")
            rolls.remove(at: index)
            dismiss()
        }
    }
}

struct RollView_Preview: PreviewProvider {
    static var previews: some View {
        @State var rolls = [Roll.example]
        NavigationView {
            RollView(rolls: $rolls, roll: Roll.example)
                .navigationTitle("Stuff")
        }
    }
}
