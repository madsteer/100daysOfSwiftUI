//
//  Activity.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/11/23.
//

import Foundation

extension Array where Element == Activity {
    func findActivity(for item: Activity) -> Index {
        let index = self.firstIndex(where: { $0.id == item.id })
        return index ?? Index(-1)
    }
}

struct Activity: Identifiable, Codable, Hashable {
    var id = UUID()
    let title: String
    var description: String
    var count = 0
}
