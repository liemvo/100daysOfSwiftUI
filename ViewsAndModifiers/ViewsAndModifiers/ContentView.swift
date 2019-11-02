//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI


struct ContentView: View {
	@State private var useRedText = false
	var body: some View {
		Color.red.largeTitle(with: "Large Title")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
