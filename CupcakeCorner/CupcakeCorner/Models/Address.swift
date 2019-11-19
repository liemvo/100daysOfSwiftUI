//
//  Address.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

struct Address: Codable {
	var name = ""
	var streetAddress = ""
	var city = ""
	var zip = ""
	
	var hasValidAddress: Bool {
		if name.isBlankOrEmpty() || streetAddress.isBlankOrEmpty() || city.isBlankOrEmpty() || zip.isBlankOrEmpty() {
			return false
		}
		return true
	}
}

extension String {
	func isBlankOrEmpty() -> Bool {
		return self.replacingOccurrences(of: " ", with: "").isEmpty
	}
}
