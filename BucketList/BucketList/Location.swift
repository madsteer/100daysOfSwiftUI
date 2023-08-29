//
//  Location.swift
//  BucketList
//
//  Created by Cory Steers on 8/29/23.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
