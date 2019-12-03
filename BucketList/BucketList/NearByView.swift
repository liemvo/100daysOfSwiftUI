//
//  NearByView.swift
//  BucketList
//
//  Created by Liem Vo on 12/3/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import URLImage

struct NearByView: View {
	let page: Page
    var body: some View {
		VStack(alignment: .center) {
			if (page.thumbnail != nil && page.thumbnail!.urlImage != nil) {
				URLImage(page.thumbnail!.urlImage!, delay: 0.25) { proxy in
					proxy.image.resizable()
						.frame(width: 90, height: 120)
					.padding(2)
				}
			} else {
				Text("No Image").frame(width: 90, height: 120)
					.background(Color.gray)
				.padding(2)
				
			}
			Text(page.title)
				.font(.body)
				.frame(width: 120)
				.opacity(0.8)
		}
    }
}
