//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Cory Steers on 8/8/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? "Unknown Friend"
    }
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }
}

extension CachedFriend : Identifiable {

}
