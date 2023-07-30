//
//  ContentView.swift
//  Project-04-BetterRest
//
//  Created by Laura Coronel on 7/28/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
	@State private var wakeUP = defaultWakeTime
	@State private var sleepAmount = 8.0
	@State private var coffeeAmount = 0
	
	var bedtime: String {
		do {
			let config = MLModelConfiguration() // Incase we need to enable a handful of options
			let model = try SleepCalculator(configuration: config) // will read in all the data and output result
			
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUP)
			let hour = (components.hour ?? 0) * 60 * 60 // in seconds
			let minute = (components.minute ?? 0) * 60 // in seconds
			
			let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
			
			let sleepTime = wakeUP - prediction.actualSleep
			return sleepTime.formatted(date: .omitted, time: .shortened)
		} catch {
			return "There was an error"
		}
		
	}
	
	static var defaultWakeTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date.now
	}
	
    var body: some View {
		NavigationStack {
			Form {
				Section("When do you want to wake up?") {
					DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute)
						.labelsHidden()
				}
				
				Section("Desired amount of sleep") {
					Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
				}
				
				Section("Daily coffee intake") {
//					Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
					Picker("Number of cups", selection: $coffeeAmount) {
						ForEach(1..<21) {
							Text(String($0))
						}
					}
				}
				
				Text("Your ideal bedtime is \(bedtime)")
					.font(.title)
			}
			.navigationTitle("BetterRest")
		}
    }
}

#Preview {
    ContentView()
}
