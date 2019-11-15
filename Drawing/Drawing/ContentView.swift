//
//  ContentView.swift
//  Drawing
//
//  Created by Liem Vo on 11/13/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	private let unitPoints = [UnitPoint.top, UnitPoint.bottom, UnitPoint.leading, UnitPoint.trailing, UnitPoint.center]
	private let unitPointsName = ["Top", "Bottom", "Leading", "Trailing", "Center"]
	@State private var colorCycle = 0.0
	
	@State private var currentStart = 0
	@State private var currentEnd = 3
	
	var body: some View {
		VStack {
			ColorCyclingRectangle(amount: self.colorCycle, startPoint: unitPoints[currentStart], endPoint: unitPoints[currentEnd])
				.frame(width: 360, height: 240)
				.padding(.bottom)
			
			Text("Change Color")
			Slider(value: $colorCycle)
				.padding(.bottom)
			
			Text("Start Point")
			Picker("Start Point", selection: $currentStart) {
				ForEach(0 ..< unitPoints.count) {
					Text(self.unitPointsName[$0])
				}
			}.pickerStyle(SegmentedPickerStyle())
				.padding(.bottom)
			
			
			Text("End Point")
			Picker("End Point", selection: $currentEnd) {
				ForEach(0 ..< unitPoints.count) {
					Text(self.unitPointsName[$0])
				}
			}.pickerStyle(SegmentedPickerStyle())
				.padding(.bottom)
		}
		.padding()
		
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
