//
//  User.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct User: Equatable, Identifiable, Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case id, name, age, company, friends
    }
    
    var id: String
    var name: String
    var age: Int
    var company: String
    var friends: [Friend]
}
