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
	@State private var animationAmount = [0.0, 0.0, 0.0]
	@State private var opacities = [1.0, 1.0, 1.0]
	//	@State private var buttons: [View]
	
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
						withAnimation(.easeOut(duration: 1)) {
							if number == self.correctAnswer {
								self.animationAmount[number] += 360
								switch number {
								case 0:
									self.opacities[1] = 0.75
									self.opacities[2] = 0.75
								case 1:
									self.opacities[0] = 0.75
									self.opacities[2] = 0.75
								default:
									self.opacities[0] = 0.75
									self.opacities[1] = 0.75
								}
							} else {
								self.opacities[number] = 0.2
							}
						}
					}) {
						Color.white.flagStyle(of: self.countries[number])
							.rotation3DEffect(.degrees(self.animationAmount[number]), axis: (x: 0, y: 1, z: 0))
							.opacity(self.opacities[number])
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
		opacities = [1.0, 1.0, 1.0]
		animationAmount = [0.0, 0.0, 0.0]
		countries = countries.shuffled()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
