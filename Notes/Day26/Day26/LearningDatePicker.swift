//
//  LearningDatePicker.swift
//  Day 26
//
//  Created by Laura Coronel on 7/27/23.
//

import SwiftUI

struct LearningDatePicker: View {
	@State private var wakeUp = Date.now
	
	var body: some View {
		DatePicker("Please enter a time", selection: $wakeUp, in: Date.now...)
	}
}

#Preview {
    LearningDatePicker()
}
