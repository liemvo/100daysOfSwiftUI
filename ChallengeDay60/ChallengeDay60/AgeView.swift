//
//  AgeView.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct AgeView: View {
	var number: Int
	var padding: CGFloat = 32.0
	var body: some View {
		Text("\(number)")
			.font(.largeTitle)
			.padding(padding)
			.background(number < 25 ? Color.green: number < 40 ? Color.blue : Color.gray)
			.foregroundColor(.white)
			.clipped()
			.clipShape(Circle())
	}
}

struct AgeView_Previews: PreviewProvider {
	static var previews: some View {
		AgeView(number: 25, padding: 20)
	}
}
