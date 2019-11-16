//
//  HabitType.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation

enum HabitType: String, Codable {
	case VeryGood = "Very Good"
	case Good = "Good"
	case Normal = "Normal"
	case Bad = "Bad"
	case VeryBad = "Very Bad"
	
	static func typeOf(type: String) -> HabitType {
		switch type {
		case Self.VeryGood.rawValue:
			return .VeryGood
		case Self.Good.rawValue:
			return .Good
		case Self.Normal.rawValue:
			return .Normal
		case Self.Bad.rawValue:
			return .Bad
		case Self.VeryBad.rawValue:
			return .VeryBad
		default:
			return .Normal
		}
	}
}
