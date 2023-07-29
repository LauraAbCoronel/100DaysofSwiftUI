# Day 27: Project 4, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/27)

### Building a basic layout
* This app is going to allow user input with a date picker and two steppers, which combined will tell us when they want to wake up, how much sleep they usually like, and how much coffee they drink
* This video we just got the UI all set up
* We have a VStack that holds all our UI
* A DatePicker for the user to select the time they would like to wake up
``` swift
Text("When do you( want to wake up?")
  .font(.headline)

DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute)
  .labelsHidden()
```
* Two Steppers: One for th user to pick the amount of hours they would like to sleep and the amount of coffee they intake
``` swift
Text("Desired amount of sleep")
  .font(.headline)

Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

Text("Daily coffee intake")
  .font(.headline)

Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
```
* We also added a `NavigationSlack` so that we can add a button to the toolbar up top

### Connecting SwiftUI to Core ML
* 

### Cleaning up the user interface
* 