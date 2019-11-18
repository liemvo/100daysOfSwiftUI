//
//  User.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/17/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
	enum CodingKeys: CodingKey {
		case name
	}
	@Published var name = "Paul Hudson"
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	}
}
