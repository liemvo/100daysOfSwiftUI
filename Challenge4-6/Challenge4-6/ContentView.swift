//
//  ContentView.swift
//  Challenge4-6
//
//  Created by Liem Vo on 11/9/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var level = 1
	
	@State private var numberOfQuestionPosition = 0
	
	
	@State private var gameActivie = false
	
	@State private var questions = [Question]()
	
	private let numberQuestions = ["5", "10", "20", "All"]
	var body: some View {
		NavigationView {
			Group {
				if gameActivie {
					GameView(questions: questions, numberQuestion: getNumberQuestion()) {
						self.gameActivie = false
					}
				} else {
				Form {
					Section(header: Text("Choose table level")) {
						Stepper("Number question: \(level)", value: $level, in: 1...12, step: 1) {_ in
							
						}
					}
					
					Section(header: Text("Number of question")) {
						Picker("Number quétion", selection: $numberOfQuestionPosition) {
							ForEach(0 ..< numberQuestions.count) {
								Text(self.numberQuestions[$0])
							}
						}.pickerStyle(SegmentedPickerStyle())
					}
					
					Section {
						
						Button(action: {
							self.gameActivie = true
							self.generateQuestion()
						}) {
							Text("Star Game")
						}
						
					}
				}
			}
			}
			.navigationBarTitle("Multiple 1 to 12")
		}
	}
	
	private func generateQuestion() {
		questions = [Question]()
		
		for _ in 1...100 {
			let random1 = Int.random(in: 1...level)
			let random2 = Int.random(in: 1...12)
			
			let question = Question(question: "\(random1) * \(random2)", anwswer: random1 * random2)
			questions.append(question)
		}
	}
	
	private func getNumberQuestion() -> Int {
		switch numberOfQuestionPosition {
		case 0:
			return 5
		case 1:
			return 10
		case 2:
			return 20
		default:
			return questions.count
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
