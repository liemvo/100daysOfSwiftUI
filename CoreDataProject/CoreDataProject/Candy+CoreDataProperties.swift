//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Liem Vo on 11/21/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
	
	public var wrappedName: String {
		name ?? "Unknown Candy"
	}

}
