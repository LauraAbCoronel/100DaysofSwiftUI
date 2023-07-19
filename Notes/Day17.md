# Day 17: Project 1, part two
[Link](https://www.hackingwithswift.com/100/swiftui/17)

### Reading text from the user with TextField
* We start building our app
* TextField need some special formatting/syntax for it to work with number states. 
``` swift
TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
```
* Here we need to use `value` instead of `text` and need to tell it how to format the number. So we say it's a currently and the type USD
  *  But we can make this better by asking the system what currency the user uses. 
``` swift
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
```
* Locale is a struct that is responsible for storing all the user's region settings
  * what calendar they use, how they separate thousands digits in numbers, whether they use the metric system, and more.
* We can also give the text field a format to specify the type of keyboard we want
``` swift
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
  .keyboardType(.decimalPad)
```
* Here I'm saying I want the decimal keyboard to pop up.
* The .numberPad and .decimalPad keyboard types tell SwiftUI to show the digits 0 through 9 and optionally also the decimal point, but that doesn’t stop users from entering other values.
* For example, if they have a hardware keyboard they can type what they like, and if they copy some text from elsewhere they’ll be able to paste that into the text field no matter what is inside that text. 
* That’s OK, though – the text field will automatically filter out bad values when they hit Return.
  * It does this because the text field is currency format and the state a number

### Creating pickers in a form
* Now we're adding a Picker to our app that allows users to select the number of people to split the bill with. 
* When we created the picker the default value was 4 even though our `numberOfPeople` state was set to 2
``` swift 
Picker("Number of people", selection: $numberOfPeople) {
  ForEach(2..<100) {
    Text("\($0) people")
  }
}
```
* That's because our state being set to 2 selects the index of 2. 
* Paul shows that Pickers need to be inside of a NavigationView but that's no longer needed
  * But I still add it so I can add a title to our app
* Remember that the Navigation title gets added to the `Form` b/c each view can have multiple navigation titles. 

### Adding a segmented control for tip percentages
* We add a new picker to allow the user to select the tip percentages and loop over the `tipPercentages` array
``` swift
Picker("Tip percentage", selection: $tipPercentage) {
  ForEach(tipPercentages, id: \.self) {
    Text($0, format: .percent)
  }
}
.pickerStyle(.segmented)
```
* A new thing you'll notice is the `.pickerStyle(.segmented)` that changes the picker style from dropdown list to a set of buttons/slider. 
  * But our Picker title went away
* To add a title to the picker, so that people know what it does, we add a header to our section and tell it the text to display at the top of the section like so:
``` swift
Section {
  Picker("Tip percentage", selection: $tipPercentage) {
    ForEach(tipPercentages, id: \.self) {
      Text($0, format: .percent)
    }
  }
  .pickerStyle(.segmented)
} header: {
  Text("How much tip do you want to leave?")
}
```

### Calculating the total per person
* In order to calculate the total per person we created a mutable variable and did the math inside like so:
``` swift
var totalPerPerson: Double {
  // calculate the total per person
  let peopleCount = Double(numberOfPeople + 2)
  let tipSelection = Double(tipPercentage)
  
  let tipValue = checkAmount / 100 * tipSelection
  let grandTotal = checkAmount + tipValue
  let amountPerPerson = grandTotal / peopleCount
  
  return amountPerPerson
}
```
* Now anytime we update the state our app updates automatically

### Hiding the keyboard
* There's one annoying part, once the keyboard appears for the check amount entry, it never goes away!
* This is because we're using a number/decimal keypad. Regular keypads have a return button that closes the key board.
  1. We need to give SwiftUI some way of determining whether the check amount box should currently have *focus*
  2. We need to add some kind of button to remove that focus when the user wants
* To solve the first one we use `@FocusState` which is our second property wrapper
* So we add this `@FocusState private var amountIsFocused: Bool` right under our states
* Now we're able to attach this to our text field like so:
``` swift
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
  .keyboardType(.decimalPad)
  .focused($amountIsFocused)
```
* This lets SwiftUI know whether the text field should have focus or not
* To solve the second part we add a toolbar to our keyboard. To do so we add a `toolbar` to our Form like so
``` swift
Form {...}
  .navigationTitle("WeSplit")
  .toolbar {
    ToolbarItemGroup(placement: .keyboard) {
      Spacer()
      Button("Done") {
        amountIsFocused = false
      }
    }
  }
```
* Breakdown of what we just added:
  * The `toolbar {}` modifier lets us specify toolbar items for a view
    * This can appear in various places on the screen (navbar, at the bottom)
  * `ToolbarItemGroup`: lets us place one or more buttons in a specific location. And here is where we set the placement to `.keyboard`
  * The `Button` view we use displays some tappable text, that reads "Done". We also provide it with some code to run when the button is pressed. Which in our case turns off the focus
  * The `Spacer()` will push the "Done" button all the way to the right.