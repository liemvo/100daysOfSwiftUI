//
//  UserView.swift
//  SnowSeeker
//
//  Created by Liem Vo on 12/29/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var body: some View {
		Group {
			Text("Name: Paul")
			Text("Country: England")
			Text("Pets:  Luna, Arya, and Toby")
		}
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
