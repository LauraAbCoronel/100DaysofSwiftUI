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
* 

### Showing and hiding views
* 

### Deleting items using onDelete()
* 

### Storing user settings with UserDefaults
* 

### Archiving Swift objects with Codable
* 