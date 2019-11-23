//
//  Tags.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 11/24/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

class Tags: NSObject, NSCoding {
	
	enum Key: String {
		case tags = "tags"
	}
	var tags: [String] = []
	
	init(tags: [String]) {
		self.tags = tags
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(tags, forKey: Tags.Key.tags.rawValue)
	}
	
	required convenience init?(coder: NSCoder) {
		let tags = coder.decodeObject(forKey: Key.tags.rawValue) as! [String]
		
		self.init(tags: tags)
	}
}
