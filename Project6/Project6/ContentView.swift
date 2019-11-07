//
//  ContentView.swift
//  Project6
//
//  Created by Liem Vo on 11/7/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var animationAmount  = 0.0
	var body: some View {
		
		Button("Tap Me") {
			withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
				self.animationAmount += 360
			}
		}
		.padding(50)
		.background(Color.red)
		.foregroundColor(.white)
		.clipShape(Circle())
		.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
