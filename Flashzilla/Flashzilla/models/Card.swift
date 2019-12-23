//
//  Card.swift
//  Flashzilla
//
//  Created by Liem Vo on 21/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

struct Card : Codable {
	let prompt: String
	let answer: String
	
	static var example: Card {
		return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Joddie Whittaker")
	}
}
