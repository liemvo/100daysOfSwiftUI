//
//  ContentView.swift
//  Drawing
//
//  Created by Liem Vo on 11/13/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var width: CGFloat = 80.0
	@State private var hue = 0.6
	let maxWidth: CGFloat = 360
	var body: some View {
		VStack(spacing: 0) {
			Spacer()
			Arrow(width: width)
				.stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
				.frame(width: 300, height: 600)
				.colorInvert()
			
			Spacer()
			
			Group {
				Text("Width: \(Int(width))")
				Slider(value: $width, in: 10...maxWidth, step: 1)
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
