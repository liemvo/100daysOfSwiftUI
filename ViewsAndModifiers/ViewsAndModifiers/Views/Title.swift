//
//  Title.swift
//  ViewsAndModifiers
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.foregroundColor(.white)
			.padding()
			.background(Color.blue)
			.clipShape(RoundedRectangle(cornerRadius: 10))
		
	}
}

extension View {
	func titleStyle() -> some View {
		return self.modifier(Title())
	}
}
