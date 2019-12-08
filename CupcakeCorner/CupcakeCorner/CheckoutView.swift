//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
	@ObservedObject var order: Order
	@State private var confirmationMessage = ""
	@State private var alertTitle = ""
	@State private var showingConfirmation = false
	var body: some View {
		GeometryReader { geo in
			VStack {
				Image("cupcakes")
					.resizable()
					.scaledToFit()
					.frame(width: geo.size.width)
					.accessibility(hidden: true)
				
				Text("Your total is $\(self.order.cost, specifier: "%.2f")")
				
				Button("Place order") {
					
					
					self.placeOrder()
				}
				.padding()
				Spacer()
			}
		}
		.navigationBarTitle("Checkout", displayMode: .inline)
		.alert(isPresented: $showingConfirmation) { () -> Alert in
			Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
		}
	}
	
	private func placeOrder() {
		guard let encoded = try? JSONEncoder().encode(order) else {
			print("Failed to encode order")
			return
		}
		
		let url = URL(string:"https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		request.httpBody = encoded
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				if let error = error as NSError?, error.code == -1009 {
					self.showingConfirmation = true
					self.alertTitle = "Error!"
					self.confirmationMessage = "There is no internet"
				} else {
					print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
				}
				return
			}
			
			if let decodedOrder  = try? JSONDecoder().decode(Order.self, from: data) {
				self.alertTitle = "Thank you!"
				self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
				self.showingConfirmation = true
			} else {
				print("Invalid response from server")
			}
		}.resume()
	}
}

struct CheckoutView_Previews: PreviewProvider {
	static var previews: some View {
		CheckoutView(order: Order())
	}
}
