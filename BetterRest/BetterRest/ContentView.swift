//
//  ContentView.swift
//  BetterRest
//
//  Created by Liem Vo on 11/4/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var wakeUp = defaultWakeTime
	@State private var sleepAmount = 8.0
	
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
	private let coffeeRange = 1..<20
	@State private var coffeeIndex = 0
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Bed time").font(.largeTitle)) {
					Text(alertTitle).font(.title)
					Text(alertMessage).font(.title)
				}.onAppear {
					self.calculateBedtime()
				}
				
				Section(header: Text("When do you want to wake up?")
					.font(.headline)) {
						DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
							.datePickerStyle(WheelDatePickerStyle())
				}
				
				Section(header: Text("Desired amount of sleep")
					.font(.headline)) {
						Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
							Text("\(sleepAmount, specifier: "%g") hours")
						}
					.accessibility(label: Text("Desired amount of sleep \(sleepAmount)"))
				}
				
				Section(header: Text("Daily coffee intake").font(.headline)) {
					
					Picker("Number of cup", selection: $coffeeIndex) {
						ForEach(0 ..< coffeeRange.count) {
							Text("\($0 + 1)")
						}
					}
					
				}
				
			}
			.navigationBarTitle("BetterRest")
		}
	}
	
	static var defaultWakeTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date()
	}
	
	private func calculateBedtime() {
		let model = SleepCalculator()
		
		let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
		let hour = (components.hour ?? 0) * 60 * 60
		let minute = (components.minute ?? 0) * 60
		
		do {
			let prediction = try
				model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeIndex + 1))
			let sleepTime = wakeUp - prediction.actualSleep
			let formatter = DateFormatter()
			formatter.timeStyle = .short
			
			alertMessage = formatter.string(from: sleepTime)
			alertTitle = "Your ideal bed time is ... "
		} catch {
			alertTitle = "Error"
			alertMessage = "Sorry, there was a problem calculating your bedtime."
		}
		
		showingAlert = true
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
