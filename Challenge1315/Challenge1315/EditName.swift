//
//  EditName.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import MapKit

struct EditName: View {
	@Environment(\.presentationMode) private var presentationMode
	@Binding var text: String
	@Binding var lastKnownLocation: CLLocationCoordinate2D?
	var onCommit: () -> Void = {}
	@State private var showingAlert = false
	
	let locationFetcher = LocationFetcher()
	
	var body: some View {
		
		VStack(spacing: 8.0) {
			TextField("Insert name", text: self.$text)
			Button(action: {
				if self.text.count == 0 {
					self.showingAlert = true
				} else {
					self.lastKnownLocation = self.locationFetcher.lastKnownLocation
					self.presentationMode.wrappedValue.dismiss()
					self.onCommit()
				}
			}){
				Text("Done")
			}
			
			Spacer()
		}
		.onAppear(perform: self.locationFetcher.start)
		.padding()
		.alert(isPresented: self.$showingAlert) {
			Alert(title: Text("Missing name"), message: Text("Name is not empty"), dismissButton: .cancel())
		}
	}
}

struct EditName_Previews: PreviewProvider {
	static var previews: some View {
		EditName( text: .constant("hello"), lastKnownLocation: .constant(nil))
	}
}
