//
//  EditCards.swift
//  Flashzilla
//
//  Created by Liem Vo on 23/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct EditCards: View {
	@Environment(\.presentationMode) var presentationMode
	@State private var cards = [Card]()
	@State private var newPrompt = ""
	@State private var newAnswer = ""
	
	static let KEY = "Cards"
	
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("Add new card")) {
					TextField("Prompt", text: $newPrompt)
					TextField("Answer", text: $newAnswer)
					Button("Add Card") {
						self.addCard()
					}
				}
				
				Section {
					ForEach(0..<cards.count, id: \.self) { index in
						VStack(alignment: .leading) {
							Text(self.cards[index].prompt)
								.font(.headline)
							Text(self.cards[index].answer)
								.foregroundColor(.secondary)
						}
					}
					.onDelete(perform: removeCards)
				}
			}
			.navigationBarTitle("Edit cards")
			.navigationBarItems(trailing: Button("Done", action: dismiss))
			.navigationViewStyle(StackNavigationViewStyle())
			.listStyle(GroupedListStyle())
			.onAppear(perform: loadData)
		}
	}
	
	func dismiss() {
		presentationMode.wrappedValue.dismiss()
	}
	
	func loadData() {
		if let data = UserDefaults.standard.data(forKey: Self.KEY) {
			if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
				self.cards = decoded
			}
		}
	}
	
	func saveData() {
		if let data = try? JSONEncoder().encode(cards) {
			UserDefaults.standard.set(data, forKey: "Cards")
		}
	}
	
	func addCard() {
		let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
		let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
		
		guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
		
		let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
		cards.insert(card, at: 0)
		saveData()
		newPrompt = ""
		newAnswer = ""
	}
	
	func removeCards(at offsets: IndexSet) {
		cards.remove(atOffsets: offsets)
		saveData()
	}
}

struct EditCards_Previews: PreviewProvider {
	static var previews: some View {
		EditCards()
	}
}
