//
//  Person.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/7/23.
//

import Foundation
import UIKit

struct Person: Identifiable, Equatable, Hashable {
    var id: UUID
    var firstName: String
    var lastName: String
    var pictureFilename: String
    var picture: UIImage
    
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    init(contact: Contact, picture: UIImage) {
        id = contact.id!
        firstName = contact.wrappedFirstName
        lastName = contact.wrappedLastName
        pictureFilename = contact.wrappedPictureFilename
        self.picture = picture
    }
    
    init(id: UUID, firstName: String, lastName: String, pictureFilename: String, picutre: UIImage) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.pictureFilename = pictureFilename
        self.picture = picutre
    }
}
