//
//  Friend+CoreDataProperties.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 11/23/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var user: User?

	var wrappedName: String {
		name ?? "Unknown"
	}
	
	var wrappedId: String {
		id ?? "Unknown"
	}	
}
