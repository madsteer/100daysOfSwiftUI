//
//  Activity.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/11/23.
//

import Foundation

struct Activity: Identifiable, Codable, Hashable {
    var id = UUID()
    let title: String
    let description: String
}
