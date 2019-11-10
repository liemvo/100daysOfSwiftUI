//
//  Expenses.swift
//  Project7
//
//  Created by Liem Vo on 11/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]() {
		didSet {
			let encoder = JSONEncoder()
			
			if let encoded = try? encoder.encode(items) {
				UserDefaults.standard.set(encoded, forKey: "Items")
			}
		}
	}
	
	init() {
		if let items = UserDefaults.standard.data(forKey: "Items") {
			let decoder = JSONDecoder()
			
			if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
				self.items = decoded
				return
			}
		}
		
		self.items = []
	}
}
