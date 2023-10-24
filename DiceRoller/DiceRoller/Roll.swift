//
//  Roll.swift
//  DiceRoller
//
//  Created by Cory Steers on 10/20/23.
//

import Foundation

struct Roll: Identifiable, Hashable, Codable {
    var id: UUID
    var dice: [Die]
    var total: Int
    
    static let example = Roll(id: UUID(), dice: [Die.example, Die.example], total: [Die.example, Die.example].reduce(0, {$0 + ($1.result)}))
}

