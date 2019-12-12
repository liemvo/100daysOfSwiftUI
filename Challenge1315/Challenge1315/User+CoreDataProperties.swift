//
//  User+CoreDataProperties.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI
import MapKit


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

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
	
	var userLocation: CLLocationCoordinate2D {
		get {
			CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		}
	}
	
}
