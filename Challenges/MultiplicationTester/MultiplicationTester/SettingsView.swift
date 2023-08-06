//
//  SettingsView.swift
//  MultiplicationTester
//
//  Created by Laura Coronel on 8/5/23.
//

// <a href="https://www.flaticon.com/free-icons/launch" title="launch icons">Launch icons created by Iconic Panda - Flaticon</a>

import SwiftUI

struct SettingsView: View {
	@Binding var practiceNumber: Int
	@Binding var numOfQuestions: Int // 0 is 5, 1 is 10 and 2 is 15
	@Binding var isPlaying: Bool
	
	var generateQnA: () -> Void
	
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
			Button("START") {
				isPlaying = true
				generateQnA()
			}
		}
		.padding()
    }
}

#Preview {
	SettingsView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), generateQnA: {
		print("hi")
	})
//		SettingsView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]))
}
