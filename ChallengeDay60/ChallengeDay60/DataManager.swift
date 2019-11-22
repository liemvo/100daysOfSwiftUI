//
//  DataManager.swift
//  ChallengeDay60
//
//  Created by Liem Vo on 22/11/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation
import Combine

class DataManager: ObservableObject {
	@Published var users = [User]()
	
	init() {
		fetchData()
	}
	private func fetchData() {
		guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data else { return }
			if let decodedOrder = try? JSONDecoder().decode([User].self, from: data) {
				DispatchQueue.main.async {
					self.users = decodedOrder
				}
			}
		}.resume()
	}
	
	func getUser(id: String) -> User? {
		return users.first(where: {$0.id == id})
	}
}
