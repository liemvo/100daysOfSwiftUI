//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Liem Vo on 12/29/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ResortView: View {
	let resort: Resort
    var body: some View {
        ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
				.scaledToFit()
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					
					Text("Facilities")
						.font(.headline)
						
					Text(ListFormatter.localizedString(byJoining: resort.facilities))
						.padding(.vertical)
				}
				.padding(.horizontal)
				
				HStack {
					Spacer()
					ResortDetailsView(resort: resort)
					SkiDetailsView(resort: resort)
					Spacer()
				}
				.font(.headline)
				.foregroundColor(.secondary)
				.padding(.top)
			}
		}
		.navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
