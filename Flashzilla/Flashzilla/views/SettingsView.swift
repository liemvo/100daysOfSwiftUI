//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Liem Vo on 26/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
	@Binding var isTryAgain: Bool
    var body: some View {
		VStack {
			Toggle(isOn: $isTryAgain) {
				Text("Add your wrong questions to the bottom?")
			}
		}
		
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(isTryAgain: .constant(false))
    }
}
