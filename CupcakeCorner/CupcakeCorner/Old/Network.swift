//
//  Network.swift
//  CupcakeCorner
//
//  Created by Liem Vo on 11/18/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Foundation
func loadData() {
	guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
		print("Invalid URL")
		return
	}
	
	let request = URLRequest(url: url)
	URLSession.shared.dataTask(with: request) { data,  response, error in
		if let data = data {
			if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
				DispatchQueue.main.async {
					let results = decodedResponse.results
					print(results.count)
				}
				return
			}
		}
		print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
	}.resume()
}
