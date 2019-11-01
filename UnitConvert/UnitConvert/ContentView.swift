//
//  ContentView.swift
//  UnitConvert
//
//  Created by Liem Vo on 11/1/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

enum  TemperatureType: String, CaseIterable {
	case Celsius, Fahrenheit, Kelvin
}
struct ContentView: View {
	@State private var convertAmount = ""
	
	private let temperatureUnits: [TemperatureType] = [.Celsius, .Fahrenheit, .Kelvin]
	@State private var inputUnitIndex = 0
	@State private var outputUnitIndex = 0
	var outputAmount: Double {
		let inputAmount = Double(convertAmount) ?? 0
		let inputUnit  = temperatureUnits[inputUnitIndex]
		let outputUnit = temperatureUnits[outputUnitIndex]
		if (inputUnit == outputUnit) {
			return inputAmount
		} else {
			switch inputUnit {
			case .Celsius:
				switch outputUnit {
				case .Fahrenheit:
					return CtoF(value: inputAmount)
				default:
					return CtoK(value: inputAmount)
				}
			case .Fahrenheit:
				switch outputUnit {
				case .Celsius:
					return FtoC(value: inputAmount)
				default:
					return FtoK(value: inputAmount)
				}
			case .Kelvin:
				switch outputUnit {
				case .Celsius:
					return KtoC(value: inputAmount)
				default:
					return KtoF(value: inputAmount)
				}
			}
		}
	}
	
	private func CtoF(value: Double) -> Double {
		return value * 9 / 5 + 32
	}
	
	private func CtoK(value: Double) -> Double {
		return value + 273.15
	}
	
	private func FtoC(value: Double) -> Double {
		return (value - 32) * 5 / 9
	}
	
	private func FtoK(value: Double) -> Double {
		return CtoK(value: FtoC(value: value))
	}
	
	private func KtoC(value: Double) -> Double {
		return value - 273.15
	}
	
	private func KtoF(value: Double) -> Double {
		return CtoF(value: KtoC(value: value))
	}
	
    var body: some View {
		Form {
			Section(header: Text("Input Unit")) {
				Picker("Input Unit", selection: $inputUnitIndex) {
					ForEach(0 ..< temperatureUnits.count) {
						Text("\(self.temperatureUnits[$0].rawValue)")
					}
				}.pickerStyle(SegmentedPickerStyle())
			}
			
			Section(header: Text("Output Unit")) {
				Picker("Input Unit", selection: $outputUnitIndex) {
					ForEach(0 ..< temperatureUnits.count) {
						Text("\(self.temperatureUnits[$0].rawValue)")
					}
				}.pickerStyle(SegmentedPickerStyle())
			}
			
			TextField("Number", text: $convertAmount)
				.keyboardType(.numberPad)
			
			Section(header: Text("Result")) {
				Text("Value is: \(outputAmount, specifier: "%.2f")")
			}
			
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
