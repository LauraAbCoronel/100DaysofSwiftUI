# Day 16: Project 1, part one
[Link](https://www.hackingwithswift.com/100/swiftui/16)

### WeSplit: Introduction
* We're going to build an app that helps you split a check.
* We'll learn how to:
  * Let users enter values,
  * Let users select from options,
  * Track program state
* All projects are broken down into three stages:
  1. A hands-on introduction to all the techniques you'll be learning
  2. A step-by-step guide to build the project
  3. Challenges for you to complete on your own, to take the project further.

### Understanding the basic structure of a SwiftUI app
* When you create a new project in Xcode, it sets you up with some files
  * The first file contains code for launching your app. If you create something when the app launches and keep it alive the entire time, you’ll put it here.
  * ContentView.swift contains the initial user interface (UI) for your program, and is where we’ll be doing all the work in this project.
  * `Assets.xcassets` is an asset catalog – a collection of pictures that you want to use in your app. You can also add colors here, along with app icons, iMessage stickers, and more.
  * Preview Content folder - assets for debugging/building
* All our work for this project will take place in `ContentView.swift`
* In this file, Xcode created a struct called `ContentView` that conforms to the `View` protocol
* `View` is a basic protocol that MUST be adopted by anything you want to draw on the screen
  * `View` protocol has only one requirement, which is that you have a computed property called `body` that returns `some View` 
* `var body: some View {...}` - defines a new computed property called `body` which has a type of `some View`
* The `ContentView_Previews` struct is piece of code that Xcode use so it can show a preview of your UI
* These previews use an Xcode feature called the canvas, which is usually visible directly to the right of your code.
* You can also change up the iOS device that the preview displays on 
* An important shortcut is `Option + Cmd + P` which resumes the preview if it gets stuck

### Creating a form
* `Forms` are scrolling lists of static controls like text and images, but can also include user interactive controls like text fields, toggle switches, buttons, and more.
* You can have as many things inside a form as you want, although if you intend to add more than 10, SwiftUI requires that you place things in groups to avoid problems
  * This is a limitation in SwiftUI, it was codded to understand how to add one...ten things to a form but not beyond.
* The 10 limit applies everywhere
* If you want to add more than 10 you need to use a `Group`
* `Group` doesn't change the way the UI looks, it just lets us work around SwiftUI's limitation
* If you *want* the form to look different when splitting items into chunks, you should use `Section` view instead

### Adding a navigation bar
* We notice that when we scroll our from up it covers the time and other phone icons
* To avoid this overlap you can give your app a navigation bar by wrapping our form in `NavigationView {}`
* Then to the form you must give it a navigation title like so:
``` swift
NavigationView {
  Form {
    Section {
      Text("Hello, world!")
    }
  }
  .navigationTitle("SwiftUI")
}
```
* You can also make the navigation title smaller with
  `.navigationBarTitleDisplayMode(.inline)`

### Modifying program state
* To add state to a struct you add it to the top of the struct and you must have it start with `@State`
``` swift
struct ContentView: View {
  @State private var tapCount = 0

  var body: some View {
    Button("Tap Count: \(tapCount)") { // creates a button that increments the state every time you tap it
      tapCount += 1
    }
  }
}
```
* @State allows us to work around the limitation of structs: we know we can’t change their properties because structs are fixed, but @State allows that value to be stored separately by SwiftUI in a place that can be modified.
* There are several ways of storing program state in SwiftUI, and you’ll learn all of them.
* `@State` is specifically designed for simple properties that are stored in one view.
  * Apple recommends we add private access control to those properties, like this: `@State private var tapCount = 0`.

### Binding state to user interface controls
* Things get a bit complex when we want the UI to set and display the new value
* Swift differentiates between “show the value of this property here” and “show the value of this property here, but write any changes back to the property.”
* In the case of our text field, Swift needs to make sure whatever is in the text is also in the name property, so that it can fulfill its promise that our views are a function of their state
* This is what’s called a *two-way binding*: we bind the text field so that it shows the value of our property, but we also bind it so that any changes to the text field also update the property.
* In Swift, we mark these two-way bindings with a special symbol so they stand out: we write a dollar sign before them.
``` swift
struct ContentView: View {
  @State private var name = ""
  var body: some View {
    Form {
      TextField("Enter your name", text: $name)
      Text("Hello, world!")
    }
  }
}
```
* Only use `$` when you want the UI to update the state

### Creating views in a loop
* We can use `ForEach` to loop and create a view like so:
``` swift
Form {
  ForEach(0..<100) { number in
    Text("Row \(number)")
  }
}
```
* ForEach doesn’t get hit by the 10-view limit that would affect us if we had typed the views by hand.
* `ForEach` is particularly useful when working with SwiftUI's `Picker` view, which lets us show various options for users to select from
* Example of Picker
``` swift
struct ContentView: View {
  let students = ["Harry", "Hermione", "Ron"]
  @State private var selectedStudent = "Harry"

  var body: some View {
    NavigationView {
      Form {
        Picker("Select your student", selection: $selectedStudent) {
          ForEach(students, id: \.self) {
            Text($0)
          }
        }
      }
    }
  }
}
```
* The Picker has a label, “Select your student”, which tells users what it does and also provides something descriptive for screen readers to read aloud.
* The Picker has a two-way binding to selectedStudent, which means it will start showing a selection of “Harry” but update the property when the user selects something else.
* The new part is `id: \.self`. This is needed b/c SwiftUI needs to be able to identify every view on the screen uniquely, so it can detect when things change.
  * This sets the string as the id