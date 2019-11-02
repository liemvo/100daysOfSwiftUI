//
//  Watermark.swift
//  ViewsAndModifiers
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct Watermark: ViewModifier {
	var text: String
	
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			Text(text)
				.font(.caption)
				.foregroundColor(.white)
				.padding(5)
				.background(Color.black)
		}
	}
}

extension View {
	func watermarked(with text: String) -> some View {
		self.modifier(Watermark(text: text))
	}
}
