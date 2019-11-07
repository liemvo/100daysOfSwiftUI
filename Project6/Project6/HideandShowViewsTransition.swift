//
//  HideandShowViewsTransition.swift
//  Project6
//
//  Created by Liem Vo on 11/8/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct HideandShowViewsTransition: View {
    @State private var isShowingRed = false
	
	var body: some View {
		VStack {
			Button("Tap Me"){
				withAnimation {
					self.isShowingRed.toggle()
				}
			}
			
			if isShowingRed {
				Rectangle()
					.fill(Color.red)
					.frame(width: 200, height: 200)
					.transition(.asymmetric(insertion: .scale, removal: .opacity))
			}
		}
	}
}

struct HideandShowViewsTransition_Previews: PreviewProvider {
    static var previews: some View {
        HideandShowViewsTransition()
    }
}
