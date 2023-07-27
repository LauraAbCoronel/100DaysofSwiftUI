//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Laura Coronel on 7/26/23.
//

/* CHALLENGE
 Make a brain training game that challenges players to win or lose at rock, paper, scissors.
* Each turn of the game the app will randomly pick either rock, paper, or scissors.
* Each turn the app will alternate between prompting the player to win or lose.
* The player must then tap the correct move to win or lose the game.
* If they are correct they score a point; otherwise they lose a point.
* The game ends after 10 questions, at which point their score is shown.
* Example: if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
 */

/* ATTRIBUTION
 <a href="https://www.flaticon.com/free-icons/rock-paper-scissors" title="rock paper scissors icons">Rock paper scissors icons created by Freepik - Flaticon</a>
 */

import SwiftUI

struct ContentView: View {
	@State private var computerChoice: String = choices.randomElement() ?? "Rock"
	@State private var condition: String = conditions.randomElement() ?? "Lose"
	@State private var score: Int = 0
	@State private var showingFinalScore = false
	@State private var questionCounter = 1
	
	static let choices = ["Rock", "Paper", "Scissor"]
	static let conditions = ["Win", "Lose"]
	
    var body: some View {
		ZStack {
			LinearGradient(
			stops: [
			Gradient.Stop(color: Color(red: 1, green: 0.9, blue: 0), location: 0.27),
			Gradient.Stop(color: Color(red: 0.03, green: 0.7, blue: 0.74), location: 1.00),
			],
			startPoint: UnitPoint(x: 0.5, y: 0),
			endPoint: UnitPoint(x: 0.5, y: 1)
			)
			.ignoresSafeArea()
			VStack {
				Spacer()
				
				HStack {
					Text("Rock, Paper, Scissors")
						.font(.largeTitle.bold())
					Image("rock-paper-scissors")
				}
				
				Spacer()
				Spacer()
				
				Text(condition == "Win" ? "Win against \(computerChoice)" : "Lose to \(computerChoice)")
				.font(.title)
				.frame(maxWidth: .infinity)
				.padding(.vertical, 40)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				
				VStack(spacing: 20) {
					Text("Select your move")
						.foregroundStyle(.primary)
					ForEach(Self.choices, id: \.self) { choice in
						Button {
							checkAnswer(answer: choice)
						} label: {
							HStack {
								Image(choice)
								Text(choice)
									.foregroundColor(.primary)
							}
							.frame(maxWidth: 200)
							.padding(10)
							.background(.regularMaterial)
							.clipShape(RoundedRectangle(cornerRadius: 20))
						}
					}
				}
				
				Spacer()
				Spacer()
				
				ProgressView(value: Double(questionCounter), total: 10.0)
					.tint(Color(red: 1, green: 0.9, blue: 0))
					.scaleEffect(x: 1, y: 6, anchor: .center)
			}
			.padding()
			.alert("Final Score", isPresented: $showingFinalScore) {
				Button("Play again", action: resetGame)
			} message: {
				Text("Your score is \(score)")
			}
		}
    }
	
	func checkAnswer(answer: String) -> Void {
		switch computerChoice {
		case "Rock":
			if (answer == "Paper" && condition == "Win") || (answer == "Scissor" && condition == "Lose") {
				score += 1
			} else {
				score -= 1
			}
		case "Paper":
			if (answer == "Scissor" && condition == "Win") || (answer == "Rock" && condition == "Lose") {
				score += 1
			} else {
				score -= 1
			}
		case "Scissor":
			if (answer == "Rock" && condition == "Win") || (answer == "Paper" && condition == "Lose") {
				score += 1
			} else {
				score -= 1
			}
		default:
			print("Something went wrong")
		}
		if questionCounter < 10 {
			nextQuestion()
		} else {
			showingFinalScore = true
		}
	}
	
	func nextQuestion() {
		withAnimation {
			questionCounter += 1
		}
		
		computerChoice = Self.choices.randomElement() ?? "Rock"
		
		if condition == "Win" {
			condition = "Lose"
		} else {
			condition = "Win"
		}
	}
	
	func resetGame() {
		score = 0
		questionCounter = 0
		nextQuestion()
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
