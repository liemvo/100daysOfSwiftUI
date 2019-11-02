//
//  ContentView.swift
//  GuessFlag
//
//  Created by Liem Vo on 11/2/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	@State private var showingScore = false
	@State private var scoreTitle = ""
	
	@State private var score = 0
	
	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
			VStack (spacing: 30) {
				VStack {
					Text("Tap thge flag of")
						.foregroundColor(.white)
					
					Text(countries[correctAnswer].capitalized)
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
				}
				
				ForEach(0 ..< 3) { number in
					Button(action: {
						self.flagTapped(number)
					}) {
						Color.white.flagStyle(of: self.countries[number])
					}
				}
				
				Text("Score: \(score)")
					.foregroundColor(.white)
				
				Spacer()
			}
		}
		.alert(isPresented: $showingScore) {
			Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
				self.askQuestion()
				})
		}
	}
	
	private func flagTapped(_ number: Int) {
		scoreTitle = number == correctAnswer ? "Correct" : "Wrong! That flag is \(countries[correctAnswer])"
		score = number == correctAnswer ? score + 1 : score - 1
		showingScore = true
	}
	
	private func askQuestion() {
		countries.shuffled()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
