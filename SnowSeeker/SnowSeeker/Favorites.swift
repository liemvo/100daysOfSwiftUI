//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Liem Vo on 12/30/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
	private var resorts: Set<String>
	
	private let saveKey = "Favorites"
	
	init() {
		guard let decoded = UserDefaults.standard.object(forKey: saveKey) as? Data else {
			self.resorts = []
			return
			
		}
		
		guard let resorts = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Set<String> else {
			self.resorts = []
			return
		}
		
		self.resorts = resorts
	}
	
	func contains(_ resort: Resort) -> Bool {
		resorts.contains(resort.id)
	}
	
	func add(_ resort: Resort) {
		objectWillChange.send()
		resorts.insert(resort.id)
		save()
	}
	
	func remove(_ resort: Resort) {
		objectWillChange.send()
		resorts.remove(resort.id)
		save()
	}
	
	func save() {
		guard let data = try? NSKeyedArchiver.archivedData(withRootObject: resorts, requiringSecureCoding: false) else { return }
		UserDefaults.standard.set(data, forKey: saveKey)
	}
}
