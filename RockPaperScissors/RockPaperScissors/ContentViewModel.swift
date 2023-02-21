//
//  ContentViewModel.swift
//  RockPaperScissors
//
//  Created by Cory Steers on 2/21/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    
    enum Shot: CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        
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
    
}
