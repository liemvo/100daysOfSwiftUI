//
//  CustomeAlignment.swift
//  Project18
//
//  Created by Liem Vo on 12/27/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct CustomeAlignment: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
			VStack {
				Text("@twostraws")
				.alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
				Image("paul-hudson")
					.resizable()
					.frame(width: 64, height: 64)
			}

			VStack {
				Text("Full name:")
				Text("PAUL HUDSON")
					 .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
					.font(.largeTitle)
			}
		}
    }
}

struct CustomeAlignment_Previews: PreviewProvider {
    static var previews: some View {
        CustomeAlignment()
    }
}

extension VerticalAlignment {
	struct MidAccountAndName: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d[.top]
		}
	}

	static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
