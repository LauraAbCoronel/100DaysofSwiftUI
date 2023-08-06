//
//  GameView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct GameView: View {
	@Binding var isPlaying: Bool
	@Binding var questions: [String]
	@Binding var answers: [Int]
	@Binding var choices: [[Int]]
	
	var generateQnA: () -> Void
	
	@State private var questionCounter = 0
	@State private var score = 0
	
	@State private var showingFinalScore = false
	
    var body: some View {
		VStack {
			Text("What is....")
				.font(.title)
			Text("\(questions[questionCounter]) ?")
				.font(.largeTitle)
			HStack {
				
				ForEach(choices[questionCounter], id: \.self) { ans in
					Button("\(ans)") {
						evaluateAnswer(selected: ans)
					}
				}
			}
			Text("Score: \(score)")
		}
		.alert("Show Final Score", isPresented: $showingFinalScore) {
			Button("Play Again?") {
				questionCounter = 0
				score = 0
				generateQnA()
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
	GameView(isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]), generateQnA: {
		print("hi")
	})
//	GameView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]))
}
