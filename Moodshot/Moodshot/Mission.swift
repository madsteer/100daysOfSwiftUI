//
//  Mission.swift
//  Moodshot
//
//  Created by Cory Steers on 4/24/23.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description:String
}
