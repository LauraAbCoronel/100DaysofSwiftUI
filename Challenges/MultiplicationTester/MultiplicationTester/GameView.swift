//
//  GameView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct GameView: View {
	@Binding var questions: [String]
	@Binding var answers: [Int]
	@Binding var isPlaying: Bool
	
//	@State private var questions = ["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]
//	@State private var answers = [8, 3, 4, 10, 20]
	
	@State private var questionCounter = 0
	@State private var score = 0
	
	@State private var showingFinalScore = false
	
	var possibleAnswers: [Int] {
		let question = questions[questionCounter]
		let answer = answers[questionCounter]
		
		let num1 = Int(question.prefix(1)) ?? 2
		let num2 = Int(question.suffix(1)) ?? 2
		
		let largest = min(num1, num2)
		return [answer - largest, answer, answer + largest].shuffled()
	}
	
    var body: some View {
		VStack {
			Text("What is....")
				.font(.title)
			Text("\(questions[questionCounter]) ?")
				.font(.largeTitle)
			HStack {
				
				ForEach(possibleAnswers, id: \.self) { ans in
					Button("\(ans)") {
						evaluateAnswer(selected: ans)
					}
				}
			}
			Text("Score: \(score)")
		}
		.alert("Show Final Score", isPresented: $showingFinalScore) {
			Button("Play Again?") {
				// do nothing
			}
			Button("Settings") {
				isPlaying = false
				
			}
		} message: {
			Text("Your final score was: \(score)")
		}
    }
	
	func evaluateAnswer(selected: Int) {
		if selected == answers[questionCounter] {
			score += 1
		}
		
		if questionCounter < questions.count - 1 {
			nextQuestion()
		} else {
			showingFinalScore = true
		}
	}
	
	func nextQuestion() {
		questionCounter += 1
	}
}

#Preview {
//	GameView()
	GameView(questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), isPlaying: .constant(true))
}
