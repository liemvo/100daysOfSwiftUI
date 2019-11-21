//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Liem Vo on 11/21/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
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

	public var wrappedFirstName: String {
		firstName ?? "Unknown Name"
	}
	
	public var wrappedLastName: String {
		lastName ?? "Unknown Name"
	}
}
