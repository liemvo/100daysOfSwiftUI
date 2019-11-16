//
//  Activity.swift
//  HabitTracking
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
import Foundation
struct Activity: Identifiable, Codable {
	let id = UUID()
	var title: String
	var type: String
	var description: String
	var repeatTime: Int
}
