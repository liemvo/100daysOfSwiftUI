//
//  ContentView.swift
//  Instafilter
//
//  Created by Liem Vo on 11/24/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	@State private var blurAmount: CGFloat = 0 {
		didSet {
			print("New value is \(blurAmount)")
		}
	}
	var body: some View {
		
		let blur = Binding<CGFloat>(
			get: {
				self.blurAmount
			},
			set: {
				self.blurAmount = $0
				print("New value is \(self.blurAmount)")
			}
		)
		
		return VStack {
			Text("Hello, World!")
				.blur(radius: blurAmount)
			Slider(value: blur, in: 0...20)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
