# Day 36: Project 7, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/36)

### iExpense: Introduction
* In this project, we're going to build iExpense, an expense tracker that separates personal cost from business costs.
* At it's core this is an app with a form (enter transaction) and a list (all transactions).
* What we will be learning:
  * Present and dismiss a second screen of data
  * Delete rows from a list
  * Save and load user data

### Why @State only works with structs
* SwiftUi's `State` property wrapper is designed for simple data that is local to the current view, but as soon as you want to share data between views it stops being useful.
* In practice, what this means is that if we have two SwiftUI views and we send them both the same struct to work with, they actually each have a unique copy of that struct; if one changes it, the other won’t see that change. 
* On the other hand, if we create an instance of a class and send that to both views, they will share changes.
  * This means is that if we want to share data between multiple views we need to use classes rather than structs.
* So we changed our example to use a class but updating the text field does NOT update the view
``` swift
class User {
	var firstName = "Bilbo"
	var lastname = "Baggins"
}

struct ContentView: View {
	@State private var user = User()
	
    var body: some View {
        VStack {
			Text("Your name is \(user.firstName) \(user.lastname)")
			
			TextField("First name", text: $user.firstName)
			TextField("Last name", text: $user.lastname)
        }
        .padding()
    }
}
```
* This is because User is a class now and with classes whenever we call a class we get the reference to the class not the class itself. So changing values in the class does NOT change the reference  

### Sharing SwiftUI state with @StateObject
* If you want to use a class with your SwiftUI data – which you will want to do if that data should be shared across more than one view – then SwiftUI gives us three property wrappers that are useful: `@StateObject`, `@ObservedObject`, and `@EnvironmentObject`.
* In this video we're solving the issue we had in the previous video where the view wouldn't update when we updated data in a class
  * To fix this, we need to tell SwiftUI when interesting parts/variables of our class have changed. 
* We can do this with `@Published` if we add that tag to the front of the class variables it will tell Swift that whenever this property changes, it should send an announcement and reload any view. 
``` swift
class User {
	@Published var firstName = "Bilbo"
	@Published var lastName = "Baggins"
}
``` 
* But for views to know that it should expect a `@Published` notification we must tag the User variable with `@StateObject` not `@State`.
  * You can remove the `private` keyword here. It depends on your usage - if you're intending to share that object with other views then remove the `private`
`@StateObject var user = User()`
* But the above throws an error stating that `User` must conform to `ObservableObject`. So all we do is add that type to `User` like so
``` swift
class User: ObservableObject {
	@Published var firstName = "Bilbo"
	@Published var lastName = "Baggins"
}
```
* As you've seen, rather than just using @State to declare local state, we now take three steps:
  1. Make a class that conforms to the `ObservableObject` protocol.
  2. Mark some properties with `@Published` so that any views using the class gets updated when they change
  3. Create an instance of our class using the `@StateObject` property wrapper.
* However, there is a catch. Like I said earlier, `@StateObject` tells SwiftUI that we’re creating a new class instance that should be watched for any change announcements, **but** that should only be used when you’re creating the object like we are with our `User` instance.
* When creating the shared data use @StateObject, but when you’re just using it in a different view you should use @ObservedObject instead.

### Showing and hiding views
* There are several ways of showing views in SwiftUI, and one of the most basic is a sheet: a new view presented on top of our existing one.
* Sheets work much like alerts, we define the conditions under which a sheet should be shown, and when those conditions become true or false the sheet will either be presented or dismissed respectively.
* Showing the sheet requires 4 steps:
  1. Create state to track whether the sheet is showing
    * `@State private var showingSheet = false`
  2. Toggle when our button is tapped
    * `showingSheet.toggle()`
  3. Attach the sheet somewhere in our view hierarchy.
    ``` swift
    .sheet(isPresented: $showingSheet) {
			SecondView() // step 4
		}
    ```
  4. Decide what to show on the sheet
* Now it works when we click the button. And to dismiss the sheet we can drag it down.
* But there will be a time where we want to dismiss it programmatically. We can do this with another property wrapper, `@Environment`.
  * This allows us to create properties that store values provided to us externally
    * Basically saying: "Figure out how my view was presented, then dismiss it appropriately"
```swift
struct SecondView: View {
	@Environment(\.dismiss) var dismiss
	let name: String
	var body: some View {
		Button("Dismiss") {
			dismiss()
		}
	}
}
```

### Deleting items using onDelete()
* SwiftUI gives us the onDelete() modifier for us to use to control how objects should be deleted from a collection.
  * This is almost exclusively used with List and ForEach: we create a list of rows that are shown using ForEach, then attach onDelete() to that ForEach so the user can remove rows they don’t want.
* 

### Storing user settings with UserDefaults
* 

### Archiving Swift objects with Codable
* 