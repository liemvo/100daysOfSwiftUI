//
//  Order.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Order: ObservableObject {
	static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
	
	@Published var type = 0
	@Published var quantity = 3
	@Published var specialRequestEnabled = false {
		didSet {
			if specialRequestEnabled == false {
				extraFrosting = false
				addSprinkles = false
			}
		}
	}
	@Published var extraFrosting = false
	@Published var addSprinkles = false
	
	@Published var address = Address()
	
	var cost: Double {
		var cost = Double(quantity) * 2
		cost += Double(type) / 2
		
		if extraFrosting {
			cost += Double(quantity)
		}
		
		if addSprinkles {
			cost += Double(quantity) / 2
		}
		
		return cost
	}
}
