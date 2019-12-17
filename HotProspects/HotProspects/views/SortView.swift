//
//  SortView.swift
//  HotProspects
//
//  Created by Liem Vo on 12/17/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct SortView: View {
	@Environment(\.presentationMode) var presentationMode
	let sortTypes = [SortType.name, SortType.email, .recent]
	@Binding var sortType: SortType
	var body: some View {
		VStack {
			Picker("Sort type", selection: $sortType) {
				ForEach(0 ..< sortTypes.count) {
					Text(self.sortTypes[$0].rawValue)
				}
			}
			Button(action: {
				self.presentationMode.wrappedValue.dismiss()
			}){Text("Done") }
		}
		.frame(height: 240)
	}
}

struct SortView_Previews: PreviewProvider {
	static var previews: some View {
		SortView(sortType: .constant(.name))
	}
}
