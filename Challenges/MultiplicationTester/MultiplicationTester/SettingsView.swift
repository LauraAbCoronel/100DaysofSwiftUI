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
	
	@State private var isAnimating = false
	var generateQnA: () -> Void
	
	var body: some View {
		ZStack {
			VStack(spacing: 50) {
				Text("Settings")
					.foregroundStyle(.white)
					.font(.largeTitle.bold())
				Spacer()
				Spacer()
				HStack {
					Text("Times Table to Practice")
						.font(.title2)
					Spacer()
					Picker("Times Table to Practice", selection: $practiceNumber) {
						ForEach(2..<13) {
							Text("Up to \($0)")
						}
					}
				}
				VStack {
					Text("How many questions?")
						.font(.title2)
					Picker("How many questions?", selection: $numOfQuestions) {
						ForEach(1..<4) {
							Text("\($0 * 5)")
						}
					}
					.pickerStyle(.segmented)
					.background()
				}
				
				
				Spacer()
				VStack {
					Image("rocket")
						.resizable()
						.frame(width: 182, height: 182)
						.scaleEffect(
							x: isAnimating ? 11.0 : 1.0,
							y: isAnimating ? 11.0 : 1.0,
							anchor: .center)
//						.position(
//							x: isPlaying ? 180 : 180,
//							y: isPlaying ? -1000 : 125
//						)
//						.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 5), value: isPlaying)
					Button("START") {
						generateQnA()
						withAnimation(.easeIn(duration: 2)) {
							isAnimating.toggle()
						} completion: {
							isPlaying = true
						}
					}
					.font(.title.bold())
					.foregroundStyle(.linearGradient(Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom))
				}
				
			}
			.foregroundStyle(.white)
			.padding()
		}
		.background(
			
			Image("space-background")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.clipped()
				.ignoresSafeArea()
		)
	}
}

#Preview {
	SettingsView(practiceNumber: .constant(0), numOfQuestions: .constant(0), isPlaying: .constant(false), generateQnA: {
		print("hi")
	})
	//		SettingsView(practiceNumber: .constant(5), numOfQuestions: .constant(0), isPlaying: .constant(false), questions: .constant(["2 X 4", "3 X 1", "4 X 1", "5 X 2", "4 X 5"]), answers: .constant([8, 3, 4, 10, 20]), choices: .constant([[8, 4, 12], [3, 0, 6], [4, 0, 8], [10, 5, 15], [20, 15, 25]]))
}
