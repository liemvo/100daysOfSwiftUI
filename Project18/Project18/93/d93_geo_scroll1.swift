//
//  d93_geo_scroll.swift
//  Project18
//
//  Created by Liem Vo on 12/27/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct d93_geo_scroll: View {
	let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	var body: some View {
		GeometryReader { fullView in
			ScrollView(.vertical) {
				ForEach(0..<50) { index in
					GeometryReader { geo in
						Text("Row #\(index)")
							.font(.title)
							.frame(width: fullView.size.width)
							.background(self.colors[index % 7])
							.rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) / 8), axis: (x: 0, y: 1, z: 0))
					}
					.frame(height: 40)
				}
			}
		}
	}
}

struct d93_geo_scroll_Previews: PreviewProvider {
	static var previews: some View {
		d93_geo_scroll()
	}
}
