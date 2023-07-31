//
//  LearningDates.swift
//  Day 26
//
//  Created by Laura Coronel on 7/27/23.
//

import SwiftUI

struct LearningDates: View {
    var body: some View {
		Text(Date.now, format: .dateTime.day().month().year())
		Text(Date.now.formatted(date:.long, time: .omitted))
    }
	
	func trivialExample() {
		let now = Date.now
		let tomorrow = Date.now.addingTimeInterval(86400)
		let range = now...tomorrow
	}
	
	func trivialExample1() {
		var components = DateComponents()
		components.hour = 8
		components.minute = 0
		let date = Calendar.current.date(from: components) ?? Date.now
	}
	func trivialExample2() {
		let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
		let hour = components.hour ?? 0
		let minute = components.minute ?? 0
	}
}

#Preview {
    LearningDates()
}
