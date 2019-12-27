//
//  93_2.swift
//  Project18
//
//  Created by Liem Vo on 12/27/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct _3_2: View {
    var body: some View {
		VStack {
			GeometryReader { geo in
				Text("Hello World!")
					.frame(width: geo.size.width * 0.9, height: 40)
					.background(Color.red)
			}
			Text("More text")
				.background(Color.blue)
		}
    }
}

struct _3_2_Previews: PreviewProvider {
    static var previews: some View {
        _3_2()
    }
}
