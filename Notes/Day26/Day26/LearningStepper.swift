//
//  ContentView.swift
//  Day 26
//
//  Created by Laura Coronel on 7/27/23.
//

import SwiftUI

struct LearningStepper: View {
	@State private var sleepAmount = 8.0
	
    var body: some View {
		Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

#Preview {
	LearningStepper()
}
