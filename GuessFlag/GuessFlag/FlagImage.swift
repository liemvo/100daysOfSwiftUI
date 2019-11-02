//
//  FlagImage.swift
//  GuessFlag
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
	var imageName: String
	func body(content: Content) -> some View {
		Image(imageName).renderingMode(.original)
			.clipShape(Capsule())
			.overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
	}
}

extension View {
	func flagStyle(of value: String) -> some View {
		return self.modifier(FlagImage(imageName: value))
	}
}
