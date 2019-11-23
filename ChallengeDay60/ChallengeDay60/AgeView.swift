//
//  AgeView.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AgeView: View {
	var number: Int16
	var padding: CGFloat = 32.0
	var font: Font = .largeTitle
	var body: some View {
		Text("\(number)")
			.font(font)
			.padding(padding)
			.background(number < 25 ? Color.green: number < 40 ? Color.blue : Color.gray)
			.foregroundColor(.white)
			.clipShape(Circle())
	}
}

struct AgeView_Previews: PreviewProvider {
	static var previews: some View {
		AgeView(number: 25, padding: 20)
	}
}
