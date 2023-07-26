//
//  ContentView.swift
//  Project-02-GuessTheFlag
//
//  Created by Laura Coronel on 7/21/23.
//

import SwiftUI

struct TitleModifier:ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle.bold())
			.foregroundColor(.blue)
	}
}

extension View {
	func title() -> some View {
		modifier(TitleModifier())
	}
}

struct ContentView: View {
	@State private var showingScore = false
	@State private var showingFinalScore = false
	@State private var scoreTitle = ""
	@State private var score = 0
	@State private var questionCounter = 1
	
	@State private var countries = allCountries.shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
	
	var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.1),
				.init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.5)
			], center: .top, startRadius: 200, endRadius: 700)
			.ignoresSafeArea()
			
			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundColor(.white)
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.foregroundStyle(.secondary)
							.font(.subheadline.weight(.heavy))
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
					}
					
					ForEach(0..<3) { number in
						Button {
							flagTapped(number)
						} label: {
							FlagImage(name: countries[number])
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				Spacer()
				Spacer()
				
				Text("Score: \(score)")
					.foregroundColor(.white)
					.font(.title.bold())
				Spacer()
			}
			.padding()
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("Your score is \(score)")
		}
		.alert("Final Score", isPresented: $showingFinalScore) {
			Button("Play again", action: restartGame)
		} message: {
			Text("You got \(score) questions out of 8")
		}
	}
	
	func flagTapped(_ number:Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
			score += 1
		} else {
			let needsThe = Set(["US","UK"])
			let theirAnswer = countries[number]
			
			if needsThe.contains(countries[number]) {
				scoreTitle = "Oops sorry, that's the flag of the \(theirAnswer)"
			} else {
				scoreTitle = "Oops sorry, that's the flag of \(theirAnswer)"
			}
		}
		if questionCounter == 8 {
			showingFinalScore = true
		} else {
			showingScore = true
		}
		
	}
	
	func askQuestion() {
		countries.remove(at: correctAnswer)
		questionCounter += 1
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
	
	func restartGame() {
		questionCounter = 0
		score = 0
		countries = Self.allCountries
		askQuestion()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
