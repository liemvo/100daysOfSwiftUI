//
//  UserView.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct UserView: View {
	@ObservedObject var dataManager: DataManager
	var currentUser: User
	
	var body: some View {
		ScrollView {
			VStack {
				Section(header: Text("Basic Info").font(.headline)) {
					VStack(alignment: .leading) {
						Text(currentUser.name)
							.font(.largeTitle)
							.foregroundColor(.blue)
						HStack {
							Text("Age").foregroundColor(.gray)
							AgeView(number: currentUser.age, padding: 8)
							Spacer()
						}
						
						HStack {
							Text("Address: ").foregroundColor(.gray)
							Text(currentUser.address)
						}
						HStack {
							Text("Company: ").foregroundColor(.gray)
							Text(currentUser.company)
						}
						HStack {
							Text("Email: ").foregroundColor(.gray)
							Text(currentUser.email)
						}
						HStack {
							Text("Register: ").foregroundColor(.gray)
							Text("\(currentUser.registerDateFormater)")
						}
					}.padding()
				}
				
				Section(header: Text("About").font(.headline)) {
					Text(currentUser.about)
				}.padding()
				
				Section(header: Text("Friend").font(.headline)) {
					
					ForEach(currentUser.friends) { friend in
		
						NavigationLink(destination: UserView(dataManager: self.dataManager, currentUser: self.dataManager.getUser(id: friend.id)!)) {
							HStack {
								Text(friend.name)
								Spacer()
							}
						}
					}
				}.padding()
			}
		}
	}
	
}

struct UserView_Previews: PreviewProvider {
	static var previews: some View {
		UserView( dataManager: DataManager(), currentUser: User(
			id: "Hdiowiw",
			isActive: true,
			name: "Test",
			age: 30,
			company: "Amaaa",
			email: "giwho@gmail.com",
			address: "",
			about: "this is a test a bout information",
			registered: "2019-10-23",
			tags: ["244", "swiftui"],
			friends: []
		))
	}
}
