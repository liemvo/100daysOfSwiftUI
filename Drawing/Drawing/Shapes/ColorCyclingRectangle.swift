//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
	var amount = 0.0
	var steps = 100
	var startPoint: UnitPoint
	var endPoint: UnitPoint
	
    var body: some View {
		ZStack {
			ForEach(0 ..< steps) { value in
				Rectangle()
					.inset(by: CGFloat(value))
					.strokeBorder(LinearGradient(gradient: Gradient(colors: [
						self.color(for: value, brightness: 1),
						self.color(for: value, brightness: 0.5)
					]), startPoint: self.startPoint, endPoint: self.endPoint), lineWidth: 2)
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

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
		ColorCyclingRectangle(startPoint: .top, endPoint: .bottom)
    }
}
