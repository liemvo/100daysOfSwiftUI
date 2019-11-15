//
//  Arrow.swift
//  Drawing
//
//  Created by Liem Vo on 11/16/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
	var width: CGFloat
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let tempHeight = rect.maxY / 3
		
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y:tempHeight))
		
		
		path.addLine(to: CGPoint(x: (rect.maxX - width)  / 2, y: tempHeight))
		path.addLine(to: CGPoint(x: (rect.maxX - width)  / 2, y: rect.maxY))
		path.addLine(to: CGPoint(x: (rect.maxX + width)  / 2, y: rect.maxY))
		path.addLine(to: CGPoint(x: (rect.maxX + width)  / 2, y: tempHeight))
		
		path.addLine(to: CGPoint(x: rect.maxX, y:tempHeight))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		
		return path
	}
}
