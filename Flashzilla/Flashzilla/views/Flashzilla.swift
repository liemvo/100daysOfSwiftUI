//
//  Flashzilla.swift
//  Flashzilla
//
//  Created by Liem Vo on 26/12/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct Flashzilla: View {
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	@Environment(\.accessibilityEnabled) var accessibilityEnabled
	@State private var cards = [Card]()
	@State private var timeRemaining = 100
	@State private var isActive = true
	@State private var showingEditScreen = false
	
	@Binding var isTryAgain: Bool
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	var body: some View {
		ZStack {
			Image(decorative: "background")
				.resizable()
				.scaledToFill()
				.edgesIgnoringSafeArea(.all)
			VStack {
				Text("Time: \(timeRemaining)")
					.font(.largeTitle)
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(
						Capsule()
							.fill(Color.black)
							.opacity(0.75)
				)
				ZStack {
					ForEach(0..<cards.count, id: \.self) { index in
						
						CardView(card: self.cards[index]) { isCorrect in
							
							withAnimation {
								self.removeCard(at: index,correct:  isCorrect)
							}
						}
						.stacked(at: index, in: self.cards.count)
						.allowsHitTesting(index == self.cards.count - 1 || index == self.cards.count)
						.accessibility(hidden: index < self.cards.count - 1)
					}
					.allowsHitTesting(timeRemaining > 0)
					if cards.isEmpty {
						Button("Start Again", action: resetCards)
							.padding()
							.background(Color.white)
							.foregroundColor(.black)
							.clipShape(Capsule())
					}
				}
				
			}
			
			VStack {
				HStack {
					Spacer()
					
					Button(action: {
						self.showingEditScreen = true
					}) {
						Image(systemName: "plus.circle")
							.padding()
							.background(Color.black.opacity(0.7))
							.clipShape(Circle())
					}
				}
			}
			.foregroundColor(.white)
			.font(.largeTitle)
			.padding()
			
			if differentiateWithoutColor || accessibilityEnabled {
				VStack {
					Spacer()
					HStack {
						Button(action: {
							withAnimation {

								self.removeCard(at: self.cards.count - 1, correct: false)
							}
						}) {
							Image(systemName: "xmark.circle")
								.padding()
								.background(Color.black.opacity(0.7))
								.clipShape(Circle())
						}
						.accessibility(label: Text("Wrong"))
						.accessibility(hint: Text("Mark your answer as being incorrect."))
						Spacer()
						Button(action: {
							withAnimation {
								self.removeCard(at: self.cards.count - 1, correct: true)
							}
						}) {
							Image(systemName: "checkmark.circle")
								.padding()
								.background(Color.black.opacity(0.7))
								.clipShape(Circle())
						}
						
					}
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
				}
			}
		}
		.onReceive(timer) { time in
			guard self.isActive else { return }
			if self.timeRemaining > 0 {
				self.timeRemaining -= 1
			}
		}
		.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
			self.isActive = false
		}
		.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
			if self.cards.isEmpty == false {
				self.isActive = true
			}
		}
		.sheet(isPresented: $showingEditScreen,onDismiss: resetCards) {
			EditCards()
		}
		.onAppear {
			guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
			
			do {
				let engine = try CHHapticEngine()
				try engine.start()
			} catch {
				print("There was an error creating the engine: \(error.localizedDescription)")
			}
			self.resetCards()
		}
	}
	
	func removeCard(at index: Int, correct isCorrect: Bool) {
		guard index >= 0 else { return }
		print(index)
		let card = cards[index]
		var tempCards = cards
		tempCards.remove(at: index)
		if self.isTryAgain && !isCorrect {
			tempCards.insert(card, at: 0)
		}
		self.cards = tempCards
		isInActiveWhenEmpty()
	}
	
	func isInActiveWhenEmpty() {
		if cards.isEmpty {
			isActive = false
		}
	}
	
	func resetCards() {
		timeRemaining = 100
		isActive = true
		loadData()
	}
	
	func loadData() {
		if let data = UserDefaults.standard.data(forKey: EditCards.KEY) {
			if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
				self.cards = decoded
			}
		}
	}
}

struct Flashzilla_Previews: PreviewProvider {
	static var previews: some View {
		Flashzilla(isTryAgain: .constant(false))
	}
}
