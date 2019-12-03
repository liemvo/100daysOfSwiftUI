//
//  Result.swift
//  BucketList
//
//  Created by Liem Vo on 12/3/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation


struct Result: Codable {
	let query: Query
}

struct Query: Codable {
	let pages: [Int: Page]
}

struct Page: Codable, Comparable {
	static func == (lhs: Page, rhs: Page) -> Bool {
		lhs.pageid == rhs.pageid
	}
	
	let pageid: Int
	let title: String
	let terms: [String: [String]]?
	let thumbnail: Thumbnail?
	let coordinates: [Coordinate]?
	
	var description: String {
		terms?["description"]?.first ?? "No further information"
	}
	
	static func < (lhs: Page, rhs: Page) -> Bool {
		lhs.title < rhs.title
	}
}

struct Coordinate: Codable {
	let lat: Double
	let lon: Double
	let primary: String
	let globe: String

}

struct Thumbnail: Codable {
	let source: String
	let width: Int
	let height: Int
	
	var urlImage: URL? {
		URL(string:  "\(source)")
	}
}
