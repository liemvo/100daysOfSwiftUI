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
	var connectedUsers = [User]()
	
	var body: some View {
		ScrollView(.vertical) {
			VStack {
				Group {
					Spacer(minLength: 32)
					Text(currentUser.wrappedName)
						.font(.largeTitle)
						.foregroundColor(currentUser.isActive ? .blue : .gray)
					HStack {
						Text("Age").foregroundColor(.gray)
						AgeView(number: currentUser.age, padding: 8)
						Spacer()
					}
					
					HStack {
						Text("Address: ").foregroundColor(.gray)
						Text(currentUser.wrappedAddress)
					}
					HStack {
						Text("Company: ").foregroundColor(.gray)
						Text(currentUser.wrappedCompany)
					}
					HStack {
						Text("Email: ").foregroundColor(.gray)
						Text(currentUser.wrappedEmail)
					}
					HStack {
						Text("Register: ").foregroundColor(.gray)
						Text("\(currentUser.registerDateFormater)")
					}
				}
				Group {
					Spacer(minLength: 32)
					Text("About")
						.font(.body)
						.foregroundColor(.orange)
					Text(currentUser.wrappedAbout)
				}
				
				Spacer(minLength: 32)
				Text("Connect Friends")
					.font(.body)
					.foregroundColor(.orange)
				ScrollView(.horizontal) {
					HStack {
						ForEach(self.connectedUsers, id:\.self) { user in
							NavigationLink(destination: UserView(dataManager: self.dataManager, currentUser: user)) {
								VStack {
									AgeView(number: user.age, padding: 8)
										.padding()
									Text(user.wrappedName)
										.font(.headline)
										.lineLimit(2)
										.foregroundColor(user.isActive ? .blue : .gray)
									
								}
							}.frame(width: 160, height: 240, alignment: .topLeading)
						}
					}
				}
			}.padding()
		}
	}
	
	
	init(dataManager: DataManager, currentUser: User) {
		
		self.dataManager = dataManager
		self.currentUser = currentUser
		var connectedUsers = [User]()
		
		for i in 0 ..< currentUser.wrappedFriends.count {
			if let connectedUser = self.dataManager.getUser(id: currentUser.wrappedFriends[i].wrappedId) {
				connectedUsers.append(connectedUser)
			}
		}
		self.connectedUsers = connectedUsers
	}
}
