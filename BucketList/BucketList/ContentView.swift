//
//  ContentView.swift
//  BucketList
//
//  Created by Liem Vo on 11/30/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import LocalAuthentication
import SwiftUI


struct ContentView: View {
	
	@State private var isUnlocked = false
	
	
	var body: some View {
		VStack {
			if self.isUnlocked {
				Text("Unlocked")
			} else {
				Text("Locked")
			}
		}.onAppear {
			self.authenticate()
		}
	}
	
	func authenticate() {
		let  context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "We need to unlock your data."
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				DispatchQueue.main.async {
					if success {
						self.isUnlocked = true
					} else  {
						self.isUnlocked = false
					}
				}
			}
		} else {
			
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
