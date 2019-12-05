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
	@State private var showFailAlert = false
	var body: some View {
		ZStack {
			if isUnlocked {
				MainView()
			}else {
				Button("Unlock Places") {
					self.authentiate()
				}
				.padding()
				.background(Color.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
				
			}
		}
		.alert(isPresented: $showFailAlert) { () -> Alert in
			Alert(title: Text("Error"), message: Text( "Authentication Error"), dismissButton: .default(Text("OK")))
		}
		
		
	}
	
	private func authentiate() {
		let context = LAContext()
		var error: NSError?
		
		if  context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Please authenticate yourself to  unlock your places."
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
				DispatchQueue.main.async {
					if success {
						self.isUnlocked = true
					} else {
						self.showFailAlert = true
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
