//
//  Card.swift
//  Flashzilla
//
//  Created by Cory Steers on 10/6/23.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    let id: UUID
    let prompt: String
    let answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
