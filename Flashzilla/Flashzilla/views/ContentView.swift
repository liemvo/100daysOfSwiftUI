//
//  ContentView.swift
//  Flashzilla
//
//  Created by Liem Vo on 19/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CoreHaptics


struct ContentView: View {
	
	@State var isTryAgain: Bool = false
	
	var body: some View {
		TabView {
			Flashzilla(isTryAgain: $isTryAgain)
				.tabItem {
					Image(systemName: "play")
					Text("Flash")
			}
			SettingsView(isTryAgain: $isTryAgain)
				.tabItem {
					Image(systemName: "add")
					Text("Settings")
			}
		}
		.onAppear {
			self.isTryAgain = UserDefaults.standard.bool(forKey: "isTry")
		}
		.onDisappear {
			UserDefaults.standard.set(self.isTryAgain, forKey: "isTry")
		}
	}
}

extension View {
	func stacked(at position: Int, in total: Int) -> some View {
		let offset = CGFloat(total - position)
		return self.offset(CGSize(width: 0, height: offset * 10))
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
