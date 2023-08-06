//
//  ContentView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct ContentView: View {
	@State private var isPlaying = false
	@State private var questions = [String]()
	@State private var answers = [Int]()
	@State private var choices = [[Int]]()
	
    var body: some View {
		if !isPlaying {
			QuestionGeneratorView(isPlaying: $isPlaying, questions: $questions, answers: $answers, choices: $choices)
		} else {
			GameView(questions: $questions, answers: $answers, isPlaying: $isPlaying)
		}
    }
}

#Preview {
    ContentView()
}
