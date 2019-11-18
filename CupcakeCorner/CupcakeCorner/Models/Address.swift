//
//  Address.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

struct Address {
	var name = ""
	var streetAddress = ""
	var city = ""
	var zip = ""
	
	var hasValidAddress: Bool {
		if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
			return false
		}
		return true
	}
}
