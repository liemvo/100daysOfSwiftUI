//
//  ColorCyclingCircle.swift
//  Drawing
//
//  Created by Liem Vo on 11/14/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
	var amount = 0.0
	var steps = 100
	var body: some View {
		ZStack {
			ForEach(0 ..< steps) { value in
				Circle()
					.inset(by: CGFloat(value))
					.strokeBorder(LinearGradient(gradient: Gradient(colors: [
						self.color(for: value, brightness: 1),
						self.color(for: value, brightness: 0.5)
					]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
			}
		}.drawingGroup()
	}
	
	private func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(self.steps) + self.amount
		
		if targetHue >  1 {
			targetHue -= 1
		}
		
		return Color(hue: targetHue, saturation: 1, brightness: brightness)
	}
}

