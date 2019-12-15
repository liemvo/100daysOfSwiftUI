//
//  Prospects.swift
//  HotProspects
//
//  Created by Liem Vo on 12/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
	@Published var people: [Prospect]
	
	init() {
		self.people = []
	}
	
	
	func toggle(_ prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
	}
}
