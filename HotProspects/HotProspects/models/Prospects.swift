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
	static let savedFile = "SavedProspects.txt"
	
	init() {
		
		let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.savedFile)
		
		do {
			let data = try Data(contentsOf: filename)
			people = try JSONDecoder().decode([Prospect].self, from: data)
			return
		} catch {
			print("Unable to load saved data.")
		}
		
		self.people = []
		
	}

	func add(_ prospect: Prospect) {
		prospect.position = people.count
		people.append(prospect)
		saveData()
	}
	
	func toggle(_ prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
		saveData()
	}
	
	static func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	func saveData() {
		do {
			let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.savedFile)
			let data = try JSONEncoder().encode(self.people)
			try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
		} catch {
			print("Unable to save data.")
		}
	}
}

class Prospect: Identifiable, Codable {
	
	let id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	var position = 0
	fileprivate(set) var isContacted = false
}
