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
			VStack {
				TextField("Enter your word", text: $newWord, onCommit: addNewWord)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.autocapitalization(.none)
					.padding()
				
				List(usedWords, id:\.self) {
					Image(systemName: "\($0.count).circle")
					Text($0)
				}
				Text("Your score: \(score)").font(.headline)
			}
			.navigationBarTitle(rootWord)
			.onAppear(perform: startGame)
			.alert(isPresented: $showErrorMessage) {
				Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
			}
			.navigationBarItems(leading: Button("Restart") {
				self.startGame()
			})
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
	
	private func startGame() {
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: startWordsURL) {
				let allWords = startWords.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "silkworm"
				usedWords.removeAll()
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
