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
					.aspectRatio(contentMode: .fit)
					.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.width * 3 / 2)
				Text(self.user.wrappedName)
					.font(.headline)
				Spacer()

			}
		}
		
    }
}
