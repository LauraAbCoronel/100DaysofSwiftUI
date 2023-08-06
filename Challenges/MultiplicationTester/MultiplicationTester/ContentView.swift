//
//  ContentView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct ContentView: View {
	@State private var practiceNumber = 2
	@State private var numOfQuestions = 0 // 0 is 5, 1 is 10 and 2 is 15
	
	@State private var isPlaying = false
	@State private var questions = [String]()
	@State private var answers = [Int]()
	@State private var choices = [[Int]]()
	
    var body: some View {
		if !isPlaying {
			QuestionGeneratorView(practiceNumber: $practiceNumber, numOfQuestions: $numOfQuestions, isPlaying: $isPlaying, generateQnA: generateQnA)
		} else {
			GameView(isPlaying: $isPlaying, questions: $questions, answers: $answers, choices: $choices, generateQnA: generateQnA)
		}
    }
	
	func generateQnA() {
		questions.removeAll()
		answers.removeAll()
		choices.removeAll()
		
		for _ in 1...(numOfQuestions * 5 + 5) {
			let rand1 = Int.random(in: 1...practiceNumber)
			let rand2 = Int.random(in: 1...practiceNumber)
			
			let larger = max(rand1, rand2)
			let answer = rand1 * rand2
			
			questions.append("\(rand1) X \(rand2)")
			answers.append(answer)
			choices.append([answer - larger, answer, answer + larger].shuffled())
		}
		isPlaying = true
	}
}

#Preview {
    ContentView()
}

