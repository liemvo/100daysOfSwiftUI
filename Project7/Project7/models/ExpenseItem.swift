//
//  ExpenseItem.swift
//  Project7
//
//  Created by Liem Vo on 11/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
	let id = UUID()
	let name: String
	let type: String
	let amount: Double
}
