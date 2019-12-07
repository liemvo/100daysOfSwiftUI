//
//  ContentView.swift
//  VoiceOver
//
//  Created by Liem Vo on 12/6/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	let pictures = [
		"ales-krivec-15949",
		"galina-n-189483",
		"kevin-horstmann-141705",
		"nicolas-tissot-335096"
	]
	
	let labels = [
		"Tuplips",
		"Frozen tree buds",
		"Sunflowers",
		"Fireworks"
	]
	
	@State private var selectePicture  =  Int.random(in: 0...3)
	
	var body: some View {
		Image(pictures[selectePicture])
			.resizable()
			.accessibility(label:Text(labels[selectePicture]))
			.accessibility(addTraits: .isButton)
			.accessibility(removeTraits: .isImage)
			.scaledToFit()
			.onTapGesture {
				self.selectePicture = Int.random(in: 0...3)
		}
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
