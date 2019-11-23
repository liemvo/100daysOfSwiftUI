//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: User.entity(), sortDescriptors:[]) var dataBaseUsers: FetchedResults<User>
	
	init(dataManager: DataManager) {
		self.dataManager = dataManager
	}
	@ObservedObject var dataManager: DataManager
	var body: some View {
		NavigationView {
			List(self.dataManager.users, id: \.self) { user in
				NavigationLink(destination: UserView(dataManager: self.dataManager, currentUser: user)) {
					HStack {
						AgeView(number: user.age, padding: 16)
						VStack(alignment: .leading) {
							Text(user.wrappedName)
								.font(.title)
								.foregroundColor(user.isActive ? Color.blue : Color.gray)
							
							HStack {
								Text("🏢:")
									.font(.subheadline)
								Text(user.wrappedCompany)
									.font(.subheadline)
							}
							HStack {
								Text("✉️")
									.font(.subheadline)
								Text(user.wrappedEmail)
									.font(.subheadline)
							}
						}
					}
					
				}
			}
			.navigationBarTitle("Users")
			.navigationBarItems(trailing: Button(action: {
				if self.dataBaseUsers.count > 0 {
					for i in 0 ..< self.dataBaseUsers.count {
						let user = self.dataBaseUsers[i]
						self.dataManager.users.append(user)
					}
				} else {
					self.dataManager.fetchData(moc: self.moc)
				}
			}) {
				Text("Load data")
			})
		}
	}
}
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(dataManager: DataManager())
	}
}
