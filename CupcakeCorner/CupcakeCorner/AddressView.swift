//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AddressView: View {
	@ObservedObject var order: Order
    var body: some View {
		Form {
			Section {
				TextField("Name", text: $order.address.name)
				TextField("Street  Address", text: $order.address.streetAddress)
				TextField("City", text: $order.address.city)
				TextField("Zip", text: $order.address.zip)
				
			}
			
			Section {
				NavigationLink(destination: CheckoutView(order: order)) {
					Text("Check out")
				}
			}
			.disabled(order.address.hasValidAddress == false)
		}
		.navigationBarTitle("Address")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
