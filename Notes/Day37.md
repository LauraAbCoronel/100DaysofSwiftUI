# Day 37: Project 7, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/37)

### Building a list we can delete from
* The first steps was to get the UI working. So first we created data to store our expenses.
  * One to store an instance of an expense with: name, type and amount.
  * Then another to contain an array of this struct (a class)
* We saved both of these in their own file.
* In our `ContentView` file we created an instance of our class and used a list to display each in a `ForEach` view.
* We then added a button to our toolbar to add some dummy expense so that we're able to see if our code works.
* We also ended up adding the `.onDelete` modifier to the ForEach so we're able to delete items.

### Working with Identifiable items in SwiftUI
* We currently have an issue with our code. In our `ForEach` we are giving the id of name BUT name can be duplicate and that's not good. ID must be unique
``` swift
ForEach(expenses.items, id: \.name) { item in
    Text(item.name)
}
.onDelete(perform: removeItems)
```
* This is called a logic error b/c our code runs fine but the logic we passed is wrong
* We fixed this by adding a property to our `ExpenseItem` struct that creates a unique ID each time. Like this:
``` swift
struct ExpenseItem: Identifiable {
	let id = UUID()
	let name: String
	let type: String
	let amount: Double
}
```
* We also end up adding the `Identifiable` protocol to the struct. 
  * This is just for performance and the only thing required is a property with the name `id` and the value of a unique ID
* This also means we can remove the id parameter in our `ForEach` since swift knows this data is `Identifiable` 

### Sharing an observed object with a new view
* We created a new view that will contain our UI for adding new Expenses to our app. The view is pretty simple just two text fields to enter the expense name and amount and a Picker to select the type of expense.
* We then called the `.sheet` method to show our second view
* So we want our `AddView` to be able to add new expenses to our `expenses` state that we already created. So to pass that value down we added the `@ObservedObject` to our `AddView` to store the property 

### Making changes permanent with UserDefaults
* At this point, our app’s user interface is functional: you’ve seen we can add and delete items, and now we have a sheet showing a user interface to create new expenses. 
* However, the app is far from working: any data placed into `AddView` is completely ignored, and even if it weren’t ignored then it still wouldn’t be saved for future times the app is run.
* So we added a save button to our `AddView` to be able to save the value into our expenses. But we still have the issue of when our app restarts all the data goes away
* So in our Expenses class we added a `didSet` so that everytime the property is set it saves the data in `UserDefaults`.
  * But this caused an error b/c our `ExpenseItem` struct must have a `Codable` protocol.
* And to set the default to the `UserDefaults`, we added an `init` that tries to find the data and if so save it to items

### Final polish
* There are two problems with our app:
  1. Adding an expense doesn’t dismiss `AddView`; it just stays there.
  2. When you add an expense, you can’t actually see any details about it.
* To solve our first item we added an `@Environment(\.dismiss)` to our `AddView` then call `dismiss()` after we added the item to our expenses
* To fix the second we just added more Views like so
``` swift
HStack {
  VStack(alignment: .leading) {
    Text(item.name)
      .font(.headline)
    Text(item.type)
  }
  Spacer()
  Text(item.amount, format: .currency(code: "USD"))
}
```