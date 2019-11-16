//
//  Activities.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Activities: ObservableObject {
	private let KEY = "activities"
	@Published var activities = [Activity]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(activities) {
				UserDefaults.standard.set(encoded, forKey: KEY)
			}
		}
	}
	
	init() {
		if let activities = UserDefaults.standard.data(forKey: KEY) {
			let decoder = JSONDecoder()
			
			if let decoded = try? decoder.decode([Activity].self, from: activities) {
				self.activities = decoded
				
				return
			}
		}
		
		self.activities = []
	}
}
