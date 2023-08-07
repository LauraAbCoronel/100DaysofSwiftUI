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
* The `onDelete()` modifier only exists on `ForEach`, so if we want users to delete items from a list we must put the items inside a `ForEach`
* In order to make `onDelete()` work, we need to implement a method that will receive a single parameter of type `IndexSet`.
  * `IndexSet` is similar to a set of integers, except it's sorted and it's just telling us the positions of all the items in the `ForEach` that should be removed.
```swift
func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
} 
```
* We tell SwiftUI to call that method when it wants to delete data from the `ForEach`, like this:
```swift
ForEach(numbers, id: \.self) {
    Text("Row \($0)")
}
.onDelete(perform: removeRows)
```
* Now with this code above if we swipe left on the row a delete button appears and we can delete the item.
  * We could also swipe left across the entire screen and that deletes it too
* But there's a way we can allow users to delete multiple rows easily.
* So we wrapped our entire view in a `NavigationStack` then at the end of the `VStack` we added a navigation style and a `toolbar` that contains an `EditButton()`
```swift
.navigationTitle("onDelete()")
.toolbar {
  EditButton()
}
```

### Storing user settings with UserDefaults
* Most users pretty much expect apps to store their data so they can create more customized experiences, and as such it’s no surprise that iOS gives us several ways to read and write user data.
* One common way to store a small amount of data is called `UserDefaults`, and it’s great for simple user preferences.
  * Everything you store in `UserDefaults` will automatically be loaded when your app launches
  * You shouldn't store more than 512 KB
* UserDefaults is perfect for storing things like when the user last launched the app, which news story they last read, or other passively collected information.
* SwiftUI can often wrap up `UserDefaults` inside a nice and simple property wrapper called `@AppStorage` – it only supports a subset of functionality right now, but it can be really helpful.
* We created a button that increases the tap count each time it's clicked
  * To save the tap count we need to write to `UserDefaults` letting it know of the value
  `UserDefaults.standard.set(tapCount, forKey: "Tap")`
* In that line of code you can see 3 things in action:
  1. We need to use `UserDefaults.standard`. This is the built-in instance of `UserDefaults` that is attached to our app, but in more advanced apps you can create your own instances.
  2. There is a single `set()` method that accepts any kind of data – integers, Booleans, strings, and more.
  3. We attach a string name to this data, in our case it’s the key “Tap”. 
    * This key is case-sensitive, just like regular Swift strings, and it’s important – we need to use the same key to read the data back out of UserDefaults.
* So now instead of setting the default to zero we can set it to the UserDefault like this:
`UserDefaults.standard.integer(forKey: "Tap")`
* Now when we run our simulator and tap the button and run the app again the same number appears
* If the key can’t be found it just sends back 0.
* They don’t write updates immediately because you might make several back to back, so instead they wait some time then write out all the changes at once. 
* SwiftUI provides an @AppStorage property wrapper around UserDefaults, and in simple situations like this one it’s really helpful.
  * What it does is let us effectively ignore UserDefaults entirely, and just use @AppStorage rather than @State, like this:
```swift
struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}
```
* Three things to notice:
  1. Our access to the UserDefaults system is through the @AppStorage property wrapper.
  2. We attach a string name, which is the UserDefaults key where we want to store the data. 
    * We used "tapCount" but it doesn't need to match the property
  3. The rest of the property is declared as normal, including providing a default value of 0. 
    * That will be used if there is no existing value saved inside UserDefaults.
* Clearly using `@AppStorage` is easier than `UserDefaults`
  * However, right now at least `@AppStorage` doesn’t make it easy to handle storing complex objects such as Swift structs – perhaps because Apple wants us to remember that storing lots of data in there is a bad idea!

### Archiving Swift objects with Codable
* `@AppStorage` is great for storing simple settings such as integers and Booleans, but when it comes to complex data – custom Swift types, for example – we need to do a little more work.
* When working with structs, Swift gives us a protocol called `Codable`
  * `Codeable` - A protocol specifically for archiving and unarchiving data (Basically converting objects into plain text and back again)
* When working with a type that only has simple properties – strings, integers, Booleans, arrays of strings, and so on – the only thing we need to do to support archiving and unarchiving is add a conformance to Codable, like this:
```swift
struct User: Codable {
  let firstName: String
  let lastName: String
}
```
* Swift will automatically generate some code for us that will archive and unarchive User instances for us as needed, **but** we still need to tell Swift when to archive and what to do with the data.
  * This part of the process is powered by a new type called `JSONEncoder`.
    * It's job is to take something that conforms to `Codeable` and send back that object in JavaScript Object Notation (JSON)
* The `Codable` protocol doesn’t require that we use JSON, and in fact other formats are available, but it is by far the most common.
* To convert our `user` data into JSON data, we need to call the `encode()` method on a `JSONEncoder`.
  * This might throw errors
```swift
Button("Save User") {
  let encoder = JSONEncoder()
  
  if let data = try? encoder.encode(user) { // try to encode the data
    UserDefaults.standard.setValue(data, forKey: "User") // if successful save it to UserDefaults
  }
}
```
* That `data` constant is a new data type called, perhaps confusingly, `Data`.
  * It's designed to store any kind of data you can think of, such as strings, images, zip files, and more.
* When we want to access our data we should use `JSONDecoder` rather than `JSONEncoder`. But the process is basically the same