//
//  WarningModifier.swift
//  WeSplit
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct WarningModier: ViewModifier {
	var text: String
	var value: Double
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			Text(text)
				.foregroundColor(value == 0 ? .red : .white)
		}
	}
}

extension View {
	func warningmarked(with text: String, of value: Double) -> some View {
		self.modifier(WarningModier(text: text, value: value))
	}
}

