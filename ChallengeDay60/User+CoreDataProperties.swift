//
//  User+CoreDataProperties.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 11/23/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var tags: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?

	var wrappedId: String {
		id ?? ""
	}
	
	var wrappedCompany: String {
		company ?? "Unknown"
	}
	
	var wrappedEmail: String {
		email ?? "Unknown"
	}
	
	var wrappedAddress: String {
		address ?? "Unknown"
	}
	
	var wrappedAbout: String {
		about ?? "Unknown"
	}
	
	var wrappedTags: [String] {
		if let tags = tags as? Tags {
			return tags.tags
		} else {
			return []
		}
	}
	
	var wrappedName: String {
		name ?? "Unknown"
	}
	
	var wrappedRegistered: String {
		registered ?? "2019-11-22'T'01:39:29.000"
	}
	
	var wrappedFriends: [Friend] {
		guard let friends = friends else { return [] }
		return Array(friends) as! [Friend]
	}
	var registerDate: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .medium
		dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
		return dateFormatter.date(from: wrappedRegistered) ?? Date()
	}
	
	var registerDateFormater: String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .long
		return dateFormatter.string(from: registerDate)
	}
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
