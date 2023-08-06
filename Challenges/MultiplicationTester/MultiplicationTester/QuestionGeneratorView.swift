//
//  QuestionGeneratorView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct QuestionGeneratorView: View {
	@State private var practiceNumber = 2
	@State private var numOfQuestions = 0 // 0 is 5, 1 is 10 and 2 is 15
	
	@Binding var isPlaying: Bool
	@Binding var questions: [String]
	@Binding var answers: [Int]
	@Binding var choices: [[Int]]
	
    var body: some View {
		VStack {
			Text("What multiplication do you want to practice?")
			Stepper("Up To \(practiceNumber)", value: $practiceNumber, in: 2...12, step: 1)
			Text("How many questions?")
			Picker("How many questions?", selection: $numOfQuestions) {
				ForEach(1..<4) {
					Text("\($0 * 5)")
				}
			}
			.pickerStyle(.segmented)
			Button("START", action: generateQnA)
		}
		.padding()
    }
	
	func generateQnA() {
		questions.removeAll()
		answers.removeAll()
		
		for _ in 1...(numOfQuestions * 5 + 5) {
			let rand1 = Int.random(in: 1...practiceNumber)
			let rand2 = Int.random(in: 1...practiceNumber)
			
			let larger = max(rand1, rand2)
			let answer = rand1 * rand2
			
			questions.append("\(rand1) X \(rand2)")
			answers.append(answer)
			choices.append([answer - larger, answer, answer + larger])
		}
		isPlaying = true
	}
}

#Preview {
	QuestionGeneratorView(isPlaying: .constant(false), questions: .constant(["1 X 1"]), answers: .constant([1]), choices: .constant([[1,2,3]]))
}
