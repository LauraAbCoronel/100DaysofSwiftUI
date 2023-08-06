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
	
	let generateQnA: () -> Void
	
	@State private var questionCounter = 0
	@State private var score = 0
	@State private var showingFinalScore = false
	
	@State private var isAnimating = false
	
	static var planets = ["planet00", "planet01", "planet02", "planet03", "planet04", "planet05", "planet06", "planet07", "planet08", "planet09", "planet00", "planet02", "planet04", "planet06", "planet08"]
	
	var body: some View {
		ZStack {
			VStack(spacing: 20) {
				Spacer()
				Text("What is....")
					.font(.title)
				Text("\(questions[questionCounter]) ?")
					.font(.largeTitle.bold())
					.foregroundStyle(.accent)
				Spacer()
				ZStack {
					ForEach(0..<questions.count) {
						Image(GameView.planets[$0])
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 300, height: 300)
							.clipped()
							.offset(x: Double(($0 * 500) + (questionCounter * -500)))
					}
					
//					Image(GameView.planets[questionCounter])
//						.resizable()
//						.aspectRatio(contentMode: .fill)
//						.frame(width: 300, height: 300)
//						.clipped()
//						.offset(x: isAnimating ? 0 : -500)
//					
//					Image(GameView.planets[questionCounter + 1])
//						.resizable()
//						.aspectRatio(contentMode: .fill)
//						.frame(width: 300, height: 300)
//						.clipped()
//						.offset(x: isAnimating ? 500 : 0)
				}
				Spacer()
				HStack {
					ForEach(choices[questionCounter], id: \.self) { ans in
						Button() {
							withAnimation {
								evaluateAnswer(selected: ans)
							}
						} label: {
							Text("\(ans)")
								.frame(width: 85, height: 55)
								.overlay(
									RoundedRectangle(cornerRadius: 20)
										.stroke(.accent, lineWidth: 1.0)
								)
						}
					}
				}
				Spacer()
				Text("Score: \(score)")
			}
			.foregroundStyle(.white)
			.alert("Show Final Score", isPresented: $showingFinalScore) {
				Button("Play Again?") {
					questionCounter = 0
					score = 0
					GameView.planets.shuffle()
					generateQnA()
				}
				Button("Settings") {
					isPlaying = false
					
				}
			} message: {
				Text("Your final score was: \(score)")
			}
		}
		.background(
			Image("space-background")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.clipped()
				.ignoresSafeArea()
		)
	}
		
	
	func evaluateAnswer(selected: Int) {
		if selected == answers[questionCounter] {
			score += 1
		}
		
		if questionCounter < questions.count - 1 {
			questionCounter += 1
		} else {
			showingFinalScore = true
		}
	}
}

#Preview {
	GameView(isPlaying: .constant(false), questions: .constant(["2 x 4", "3 x 1", "4 x 1", "5 x 2", "4 x 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]), generateQnA: {
		print("hi")
	})
	//	GameView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]))
}
