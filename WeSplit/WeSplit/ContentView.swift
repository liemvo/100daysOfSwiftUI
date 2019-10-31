//
//  ContentView.swift
//  WeSplit
//
//  Created by Liem Vo on 10/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmout = ""
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 2
	
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentages[tipPercentage])
		let orderAmount = Double(checkAmout) ?? 0
		
		let tipValue = orderAmount / 100 * tipSelection
		let grandTotal = orderAmount + tipValue
		
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", text: $checkAmout)
						.keyboardType(.decimalPad)
					Picker("Number of peope", selection: $numberOfPeople) {
						ForEach(2 ..< 100) {
							Text("\($0) people")
						}
					}
				}
				
				Section (header: Text("How much tip do you want to leave?")) {
					Picker("Tip percent", selection: $tipPercentage) {
						ForEach(0 ..< tipPercentages.count) {
							Text("\(self.tipPercentages[$0])%")
						}
					}.pickerStyle(SegmentedPickerStyle())
				}
				
				Section {
					Text("$\(totalPerPerson, specifier: "%.2f")")
				}
			}
		.navigationBarTitle("WeSplit")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
