//
//  Contact.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/7/23.
//

import CoreLocation
import UIKit

struct Contact: Codable, Identifiable, Equatable, Hashable {
    var id: UUID
    var firstName: String
    var lastName: String
    var picture: Data
    var location: CLLocationCoordinate2D?
    
    private static let imageData = UIImage(systemName: "star.fill")?.jpegData(compressionQuality: 0.5)
    static let example = Contact(id: UUID(), firstName: "Steve", lastName: "Jobs", picture: imageData!)
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        lhs.id == rhs.id
    }
}
