//
//  ContentView.swift
//  Drawing
//
//  Created by Liem Vo on 11/13/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var innerRadius = 125.0
	@State private var outerRadius = 75.0
	@State private var distance = 25.0
	@State private var amount: CGFloat = 1.0
	@State private var hue = 0.6
	
	var body: some View {
		VStack(spacing: 0) {
			Spacer()
			Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
				.stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
				.frame(width: 300, height: 300)
			Spacer()
			
			Group {
				Text("Inner radius: \(Int(innerRadius))")
				Slider(value: $innerRadius, in: 10...150, step: 1)
					.padding([.horizontal, .bottom])
				
				Text("Outer radius: \(Int(outerRadius))")
				Slider(value: $outerRadius, in: 10...150, step: 1)
					.padding([.horizontal, .bottom])
				
				Text("Distance: \(Int(distance))")
				Slider(value: $distance, in: 1...150, step: 1)
					.padding([.horizontal, .bottom])
				
				Text("Amount: \(amount, specifier: "%.2f")")
				Slider(value: $amount)
					.padding([.horizontal, .bottom])
				
				Text("Color")
				Slider(value: $hue)
			}
		}
	
	}

}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
