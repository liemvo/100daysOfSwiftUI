//
//  UserDetailView.swift
//  Challenge1315
//
//  Created by Liem Vo on 12/10/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
	var user: User
    var body: some View {
		GeometryReader { geometry in
			VStack {
				self.user.wrappedImage
				.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(maxWidth: geometry.size.width/2, maxHeight: geometry.size.width * 3 / 4)
				Text(self.user.wrappedName)
					.font(.headline)
				MapView(location: self.user.userLocation)

			}
		.padding()
		}
		
    }
}
