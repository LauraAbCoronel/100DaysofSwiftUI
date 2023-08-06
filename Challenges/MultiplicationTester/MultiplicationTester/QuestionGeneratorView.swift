//
//  QuestionGeneratorView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

import SwiftUI

struct QuestionGeneratorView: View {
	@Binding var practiceNumber: Int
	@Binding var numOfQuestions: Int // 0 is 5, 1 is 10 and 2 is 15
	
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
		choices.removeAll()
		
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
	QuestionGeneratorView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]))
}
