//
//  Prospects.swift
//  HotProspects
//
//  Created by Liem Vo on 12/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
	@Published private(set) var people: [Prospect]
	static let saveKey = "SavedData"
	
	init() {
		
		if let data  = UserDefaults.standard.data(forKey: Self.saveKey)  {
			if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
				self.people = decoded
				return
			}
		}
		
		self.people = []
	}
	
	private func save() {
		if let encoded  = try? JSONEncoder().encode(people) {
			UserDefaults.standard.set(encoded, forKey: Self.saveKey)
		}
	}
	
	func add(_ prospect: Prospect) {
		people.append(prospect)
		save()
	}
	
	func toggle(_ prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
		save()
	}
}

class Prospect: Identifiable, Codable {
	let id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	fileprivate(set) var isContacted = false
}
