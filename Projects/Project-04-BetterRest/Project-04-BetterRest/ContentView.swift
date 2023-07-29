//
//  ContentView.swift
//  Project-04-BetterRest
//
//  Created by Laura Coronel on 7/28/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
	@State private var wakeUP = Date.now
	@State private var sleepAmount = 8.0
	@State private var coffeeAmount = 1
	
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
    var body: some View {
		NavigationStack {
			VStack {
				Text("When do you want to wake up?")
					.font(.headline)
				
				DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute)
					.labelsHidden()
				
				Text("Desired amount of sleep")
					.font(.headline)
				
				Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
				
				Text("Daily coffee intake")
					.font(.headline)
				
				Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
			}
			.navigationTitle("BetterRest")
			.toolbar {
				Button("Calculate", action: calculateBedtime)
			}
			.alert(alertTitle, isPresented: $showingAlert) {
				Button("OK") {}
			} message: {
				Text(alertMessage)
			}
		}
    }
	
	func calculateBedtime() {
		do {
			let config = MLModelConfiguration() // Incase we need to enable a handful of options
			let model = try SleepCalculator(configuration: config) // will read in all the data and output result
			
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUP)
			let hour = (components.hour ?? 0) * 60 * 60 // in seconds
			let minute = (components.minute ?? 0) * 60 // in seconds
			
			let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
			
			let sleepTime = wakeUP - prediction.actualSleep
			alertTitle = "Your ideal betime is..."
			alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
			
		} catch {
			alertTitle = "Error"
			alertMessage = "Sorry, there was a problem calculating your bedtime."
		}
		showingAlert = true
	}
}

#Preview {
    ContentView()
}
