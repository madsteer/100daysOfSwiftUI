//
//  Dice.swift
//  DiceRoller
//
//  Created by Cory Steers on 10/20/23.
//

import Foundation

struct Die: Codable,Hashable {
    var numSides = 6
    var result = 0
    
    static let example = Die(numSides: 6, result: 5)
}
