//
//  DataManager.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import CoreData
import SwiftUI
import Combine

class DataManager: ObservableObject {
	@Published var users = [User]()
	
	func fetchData(moc: NSManagedObjectContext) {
		guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data else { return }
			let jsonArray = try! JSON(data: data)
			var users = [User]()
			for i in 0 ..< jsonArray.count {
				let item = jsonArray[i]
				let user = User(context: moc)
				
				user.id = item["id"].string
				user.isActive = item["isActive"].bool ?? false
				user.name = item["name"].string
				user.age = Int16(item["age"].int ?? 0)
				user.company = item["company"].string
				user.email = item["email"].string
				user.about = item["about"].string
				user.address = item["address"].string
				user.registered = item["registered"].string
				//user.tags = item["tags"].arrayValue.joined("---")
				
				let friendJson = item["friends"].arrayValue
				let friends = NSMutableSet()
				for k in 0 ..< friendJson.count {
					let friendItem = friendJson[k]
					let friend = Friend(context: moc)
					friend.id = friendItem["id"].string
					friend.name = friendItem["name"].string
					friend.user = user
					
					friends.add(friend)
				}
				
				user.friends = friends
				users.append(user)
				try! moc.save()
			}
			
			DispatchQueue.main.async {
				self.users = users
			}
		}.resume()
	}
	
	func getUser(id: String) -> User? {
		return users.first(where: {$0.id == id})
	}
}
