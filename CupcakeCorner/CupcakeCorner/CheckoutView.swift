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
	var body: some View {
		GeometryReader { geo in
			VStack {
				Image("cupcakes")
					.resizable()
					.scaledToFit()
					.frame(width: geo.size.width)
				
				Text("Your total is $\(self.order.cost, specifier: "%.2f")")
				
				Button("Place order") {
					
				}
				.padding()
				Spacer()
			}
		}
	.navigationBarTitle("Checkout")
	}
}

struct CheckoutView_Previews: PreviewProvider {
	static var previews: some View {
		CheckoutView(order: Order())
	}
}
