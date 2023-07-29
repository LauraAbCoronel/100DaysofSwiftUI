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
* In the same way that SwiftUI makes user interface development easy, Core ML makes machine learning easy.
  * Well, once you have a trained model you can get predictions in just two lines of code – you just need to send in the values that should be used as input, then read what comes back.
* We added the ML model by just dragging and dropping the file the same place the SwiftUI files are 
  * Make sure to tick off "Copy items if needed"
* When you add an .mlmodel file to Xcode, it will automatically create a Swift class of the same name.
* You can’t see the class, and don’t need to – it’s generated automatically as part of the build process.
  * You can rename the Class by renaming the file name
* After you `import CoreML` we then can create a class instance of our model. Like so:
``` swift
do {
  let config = MLModelConfiguration() // Incase we need to enable a handful of options (Don't worry too much)
  let model = try SleepCalculator(configuration: config) // will read in all the data and output result
  
  // more code
} catch {
  // Something went wrong
}
```
* Core ML models can fail in two instances
  1. When you generate the model with `let model = try SleepCalculator(configuration: config)`
  2. When it makes predictions
* Some tricky thing we gotta do is turn coffee from Int to Double and convert the time to a Double
* This is how we can extract the hour and minute from a Date type
``` swift
let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUP)
let hour = components.hour ?? 0 // in seconds
let minute = (components.minute ?? 0) * 60 // in seconds
```
* The values we get back are optional b/c you would not ask for it so we need to use nil coalescent
* To get our prediction from our model we use `model.prediction()` Like so:
``` swift
let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
```
* We can get access to our predicted sleep amount with `prediction.actualSleep`. But it returns the number of seconds. We can get the time they should go to bed by with `let sleepTime = wakeUP - prediction.actualSleep`
* Since it's a Date we need to format it to make it look nice in our alert. We did so by writing:
``` swift
alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
```
* We got our app working!

### Cleaning up the user interface
* One improvement we're going to make with the UI is have the default wake up time be something realistic instead of the time right now
  * We do this by making a calculated variable that creates a `DateComponent` and sets the hour to 7 and the minute to 0 then returns the date
``` swift
static var defaultWakeTime: Date {
  var components = DateComponents()
  components.hour = 7
  components.minute = 0
  return Calendar.current.date(from: components) ?? Date.now
}
```
* Next to improve the look we swap out `VStack` with `Form`. And combine each text and picker with VStacks
