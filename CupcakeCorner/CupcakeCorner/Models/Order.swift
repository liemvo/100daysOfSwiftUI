//
//  Order.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
	enum CodingKeys: CodingKey {
		case type
		case quantity
		case specialRequestEnabled
		case extraFrosting
		case addSprinkles
		case address
		
	}
	
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
	
	init() {}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		type = try container.decode(Int.self, forKey: .type)
		quantity = try container.decode(Int.self, forKey: .quantity)
		specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
		extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
		addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
		address = try container.decode(Address.self, forKey: .address)
		
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(type, forKey: .type)
		try container.encode(quantity, forKey: .quantity)
		try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
		try container.encode(extraFrosting, forKey: .extraFrosting)
		try container.encode(addSprinkles, forKey: .addSprinkles)
		try container.encode(address, forKey: .address)
	}
}
