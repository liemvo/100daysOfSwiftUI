//
//  User+CoreDataProperties.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var imageData: Data?

	var wrappedName: String {
		get {
			name ?? "UnknowName"
		}
	}
	
	var wrappedImage: Image {
		get {
			(imageData != nil) ? Image(uiImage: UIImage(data: imageData!)!) : Image(systemName: "contacts")
		}
	}
}
