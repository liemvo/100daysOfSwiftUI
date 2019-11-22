//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var dataManager: DataManager
	var body: some View {
		NavigationView {
			List(dataManager.users) { user in
				NavigationLink(destination: UserView(dataManager: self.dataManager, currentUser: user)) {
					HStack {
						AgeView(number: user.age, padding: 16)
						VStack(alignment: .leading) {
							Text(user.name)
								.font(.title)
								.foregroundColor(user.isActive ? Color.blue : Color.gray)
							
							HStack {
								Text("🏢:")
									.font(.subheadline)
								Text(user.company)
									.font(.subheadline)
							}
							HStack {
								Text("✉️")
									.font(.subheadline)
								Text(user.email)
									.font(.subheadline)
							}
						}
					}
				}
			}
			.navigationBarTitle("Users")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(dataManager: DataManager())
	}
}
