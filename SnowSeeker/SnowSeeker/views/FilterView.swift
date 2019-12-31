//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Liem Vo on 12/31/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct FilterView: View {
	@Environment(\.presentationMode) var presentationMode
	let resorts: [Resort]
	@Binding var filter: String
	
	var body: some View {
		List {
			Section(header: Text("Country")) {
				ForEach(Set(resorts.map { $0.country }).map { $0 }, id:\.self) { text in
					self.buildView(text: text)
				}
			}
			
			Section(header: Text("Size")) {
				ForEach(Set(resorts.map { String($0.size) }).map { $0 }, id:\.self) { text in
					self.buildView(text: text)
				}
			}
			
			Section(header: Text("Price")) {
				ForEach(Set(resorts.map { String($0.price) }).map { $0 }, id:\.self) { text in
					self.buildView(text: text)
				}
			}
			
			HStack {
				Spacer()
				Button(action: {
					self.filter = ""
					self.presentationMode.wrappedValue.dismiss()
				}){
					Text("Clear Filter")
						.foregroundColor(.white)
						.padding(8)
						.background(Color.orange)
						.cornerRadius(8)
				}
				Spacer()
			}
		}
	}
	
	func buildView(text: String) -> some View {
		Button(action: {
			self.filter = text
			self.presentationMode.wrappedValue.dismiss()
		}) {
			HStack {
				Text(text)
				if text == self.filter {
					Spacer()
					Image(systemName: "checkmark.seal")
						.accessibility(label: Text("\(text)This is filter"))
						.foregroundColor(Color.black)
				}
			}
		}
	}
}

struct FilterView_Previews: PreviewProvider {
	static var previews: some View {
		FilterView(resorts: Bundle.main.decode("resorts.json"), filter: .constant(""))
	}
}
