//
//  Prospect.swift
//  HotProspects
//
//  Created by Liem Vo on 12/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
	let id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	fileprivate(set) var isContacted = false
}
