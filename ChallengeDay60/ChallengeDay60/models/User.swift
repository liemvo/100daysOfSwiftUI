//
//  User.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
	let id: String
	let isActive: Bool
	let name: String
	let age: Int
	let company: String
	let email: String
	let address: String
	let about: String
	let registered: String
	let tags: [String]
	let friends: [Friend]
	
	var registerDate: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .medium
		dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
		return dateFormatter.date(from: registered) ?? Date()
	}
	
	var registerDateFormater: String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .long
		return dateFormatter.string(from: registerDate)
	}
} 
