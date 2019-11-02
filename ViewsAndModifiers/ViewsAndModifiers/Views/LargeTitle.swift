//
//  LargeTitle.swift
//  ViewsAndModifiers
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct LargeTitle: ViewModifier {
	var text: String
	
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			Text(text)
				.font(.largeTitle)
				.foregroundColor(.blue)
		}
	}
}

extension View {
	func largeTitle(with text: String) -> some View {
		self.modifier(LargeTitle(text: text))
	}
}
