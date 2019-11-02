//
//  GridStack.swift
//  ViewsAndModifiers
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
	let rows: Int
	let columns: Int
	let content: (Int, Int) -> Content
	var body: some View {
		VStack {
			ForEach(0 ..< rows) { row in
				HStack {
					ForEach(0 ..< self.columns) { column in
						self.content(row, column)
					}
				}
			}
		}
	}
	
	init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
		self.rows = rows
		self.columns = columns
		self.content = content
	}
}
