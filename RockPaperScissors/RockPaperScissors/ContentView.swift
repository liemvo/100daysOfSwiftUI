//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Liem Vo on 11/3/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	private let moves = ["Rock", "Paper", "Scissors"]
	@State private var shouldWin = false
	@State private var showStatus = false
	@State private var move = Int.random(in: 0 ... 2)
	@State private var score = 0
	@State private var gameCount = 0
	@State private var buttonStatus = false
	@State private var showEndGame = false
	
	var body: some View {
		VStack {
			Text("Your core is: \(score)")
				.font(.largeTitle)
				.foregroundColor(.blue)
			
			Text("App move: \(moves[move])")
				.font(.body)
				.foregroundColor(.blue)
			
			if showStatus {
				Text("You \(shouldWin ? "win" : "lose")")
					.foregroundColor(.red)
			}
			
			HStack {
				ForEach(0 ..< 3) { number in
					Button("\(self.moves[number])"){
						self.showStatus = true
						self.beat(appNumber: self.move, userNumber: number)
						if self.shouldWin {
							self.score += 1
						}
					}.disabled(self.gameCount >= 10 || self.buttonStatus)
				}
			}.padding()
			
			HStack {
				Button("Next") {
					self.showEndGame = self.gameCount >= 10
					if self.gameCount < 10 {
						self.gameCount += 1
						self.nextMove()
						self.buttonStatus = false
					}
				}.alert(isPresented: $showEndGame) {
					Alert(title: Text("Game end"), message: Text("Your final score: \(score)"))
				}
				
				Button("Reset") {
					self.shouldWin = false
					self.score = 0
					self.gameCount = 0
					self.buttonStatus = false
					self.showEndGame = false
				}
			}.frame(width: 320, height: 40, alignment: .center)
		}
	}
	
	private func nextMove() {
		move = Int.random(in: 0 ... 2)
		showStatus = false
	}
	
	private func beat(appNumber: Int, userNumber: Int) {
		if self.gameCount >= 10 {
			showStatus = false
			return
		}
		buttonStatus = true
		
		switch move {
		case 0:
			if userNumber == 1 {
				shouldWin = true
			} else {
				shouldWin = false
			}
		case 1:
			if userNumber == 2 {
				shouldWin = true
			} else {
				shouldWin = false
			}
		default:
			if userNumber == 0 {
				shouldWin = true
			} else {
				shouldWin = false
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
