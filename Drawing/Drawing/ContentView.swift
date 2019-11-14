//
//  ContentView.swift
//  Drawing
//
//  Created by Liem Vo on 11/13/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var colorCycle = 0.0
	var body: some View {
		VStack {
			VStack {
				ColorCyclingCircle(amount: self.colorCycle)
					.frame(width: 300, height: 300)

				Slider(value: $colorCycle).padding()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
