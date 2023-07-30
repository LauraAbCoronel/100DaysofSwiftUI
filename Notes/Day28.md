# Day 28: Project 4, part 3
[Link](https://www.hackingwithswift.com/100/swiftui/28)

### Challenge!
1. Replace each `VStack` in our form with a `Section`, where the text view is the title of the section. Do you prefer this layout or the `VStack` layout? It’s your app – you choose!
* I used this format for each input
``` swift
Section {
  DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute)
    .labelsHidden()
} header: {
  Text("When do you want to wake up?")
    .font(.headline)
}
```

2. Replace the “Number of cups” stepper with a `Picker` showing the same range of values.
* I also changes the initial value of coffeeAmount to 0 so the initial value is 1
``` swift
Picker(coffeeAmount == 0 ? "cup" : "cups", selection: $coffeeAmount) {
  ForEach(1..<21) {
    Text("\($0)")
  }
}
```

3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
* I created a computed variable and moved all the function logic inside it.
``` swift
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
    alertTitle = "Error"
    alertMessage = "Sorry, there was a problem calculating your bedtime."
    showingAlert = true
  }
  return "error"
}

// In the body variable
Section {
  Text(bedtime)
    .font(.largeTitle)
} header: {
  Text("Your ideal bedtime is...")
    .font(.headline)
}
```