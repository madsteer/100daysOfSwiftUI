//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Cory Steers on 7/24/23.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    var wrappedlastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
