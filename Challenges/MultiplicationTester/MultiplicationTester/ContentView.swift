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
			QuestionGeneratorView(practiceNumber: $practiceNumber, numOfQuestions: $numOfQuestions, isPlaying: $isPlaying, questions: $questions, answers: $answers, choices: $choices)
		} else {
			GameView(practiceNumber: $practiceNumber, numOfQuestions: $numOfQuestions, isPlaying: $isPlaying, questions: $questions, answers: $answers, choices: $choices)
		}
    }
}

#Preview {
    ContentView()
}
