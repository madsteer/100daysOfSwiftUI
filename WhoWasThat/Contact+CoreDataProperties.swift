//
//  Contact+CoreDataProperties.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/7/23.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var pictureFilename: String?

    public var wrappedFirstName: String {
        firstName ?? "Unknown first name"
    }
    
    public var wrappedLastName: String {
        lastName ?? "Unknown last name"
    }
    
    public var wrappedPictureFilename: String {
        pictureFilename ?? "Unknown picture filename"
    }
}

extension Contact : Identifiable {

}
