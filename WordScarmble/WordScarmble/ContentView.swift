//
//  ContentView.swift
//  WordScarmble
//
//  Created by Liem Vo on 11/6/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var usedWords =  [String]()
	@State private var rootWord = ""
	@State private var newWord  = ""
	@State private var errorTitle = ""
	@State private var errorMessage  = ""
	@State private var showErrorMessage = false
	@State private var score = 0
	var body: some View {
		NavigationView {
			GeometryReader { fullScreen in
				ScrollView(.vertical) {
					VStack {
						TextField("Enter your word", text: self.$newWord, onCommit: self.addNewWord)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.autocapitalization(.none)
							.padding()
						
						
						ForEach(0..<self.usedWords.count, id:\.self) { index in
							GeometryReader { geo in
								HStack {
									Image(systemName:"\(self.usedWords[index].count).circle")
										.background(self.color(index: index))
									Text(self.usedWords[index])
								}
				
								.offset(x: geo.frame(in: .global).minY / 24, y: CGFloat(0))
								.accessibilityElement(children: .ignore)
								.accessibility(label: Text("\(self.usedWords[index]), \(self.usedWords[index].count) letters"))
							}
							.frame(height:40)
						}
						Text("Your score: \(self.score)").font(.headline)
					}
				}
				.navigationBarTitle(self.rootWord)
				.onAppear(perform: self.startGame)
				.alert(isPresented: self.$showErrorMessage) {
					Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
				}
				.navigationBarItems(leading: Button("Restart") {
					self.startGame()
				})
			}
		}
	}
	
	private func addNewWord() {
		let answer = newWord.lowercased()
			.trimmingCharacters(in: .whitespacesAndNewlines)
		guard answer.count > 0 else { return }
		
		guard isOriginal(word: answer) else {
			wordError(title: "Word used already", message: "Be mroe original")
			return
		}
		
		guard isReal(word: answer) else {
			wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
			return
		}
		newWord = ""
		switch answer.count {
		case 4:
			score += 1
		case 5:
			score += 5
		case 6:
			score += 10
		case 7:
			score += 15
		default:
			score += 20
		}
		usedWords.insert(answer, at: 0)
	}
	
	private func color(index: Int) -> Color {
		let value = Double(index) / Double(usedWords.count == 0 ? index : usedWords.count)
		print("\(index), \(usedWords.count), value = \(value)")
		return Color(red: Double.random(in: 0.0...1.0), green: value, blue: value)
	}
	
	private func startGame() {
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: startWordsURL) {
				let allWords = startWords.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "silkworm"
				usedWords.removeAll()
				
				[Int](repeating: 3, count: 20).enumerated().forEach { index, value in
					usedWords.append("Text \(index)")
				}
				
				return
			}
		}
		
		fatalError("Could not load start.txt from bundle.")
	}
	
	private func isOriginal(word: String) -> Bool {
		!usedWords.contains(word)
	}
	
	func isPossible(word: String) -> Bool {
		var tempWord = rootWord.lowercased()
		for letter in word {
			if let position = tempWord.firstIndex(of: letter) {
				tempWord.remove(at: position)
			} else {
				return false
			}
		}
		
		return true
	}
	
	func isReal(word: String) -> Bool {
		if (word == rootWord || word.count < 4) {
			return false
		}
		
		let checker = UITextChecker()
		
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		return misspelledRange.location == NSNotFound
	}
	
	func wordError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showErrorMessage = true
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
