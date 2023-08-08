//
//  User.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct User: Equatable, Identifiable, Codable, Hashable {    
    let id: String
        let isActive: Bool
        let name: String
        let age: Int
        let company: String
        let email: String
        let address: String
        let about: String
        let registered: String
        let tags: [String]
        let friends: [Friend]

}
