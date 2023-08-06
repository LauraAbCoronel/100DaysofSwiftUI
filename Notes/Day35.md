# Day 35: Milestone: Projects 4-6
[Link](https://www.hackingwithswift.com/100/swiftui/35)

### What you learned
* How to read numbers from users with `Stepper`, including using its shorter form when your label is a simple text view.
* Letting the user enter dates using `DatePicker`, including using the `displayedComponents` parameter to control dates or times.
* Working with dates in Swift, using `Date`, `DateComponents`, and `DateFormatter`
* How to bring in machine learning to leverage the full power of modern iOS devices.
* Building scrolling tables of data using `List`, in particular how it can create rows directly from arrays of data.
* Running code when a view is shown, using `onAppear()`.
* Reading files from our app bundle by looking up their path using the `Bundle` class, including loading strings from there.
* Crashing your code with `fatalError()`, and why that might actually be a good thing.
* How to check whether a string is spelled correctly, using `UITextChecker`.
* Creating animations implicitly using the `animation()` modifier.
* Customizing animations with delays and repeats, and choosing between ease-in-ease-out vs spring animations.
* Attaching the `animation()` modifier to bindings, so we can animate changes directly from UI controls.
* Using `withAnimation()` to create explicit animations.
* Attaching multiple `animation()` modifiers to a single view so that we can control the animation stack.
* Using `DragGesture()` to let the user move views around, then snapping them back to their original location.
* Using SwiftUI’s built-in transitions, and creating your own.

### Key points
#### Ranges with ForEach and List
* When calling `ForEach` you can send it a range like so:
``` swift
ForEach(0..<5) {
    Text("Row \($0)")
}
```
* But if you try to use the range `0...5` that will not work
  * This is because `ForEach` is designed to accept a `Range<Int>` but `0...5` is a `ClosedRange<Int>` type. 

#### What makes a string?
* We might think strings are pretty straight forward but strings are some of the most complex features in Swift
* Since strings can contain emojis (which are a bunch of characters joined together) you can't just treat it as an array and ask for the first character like this `string[0]`
* `.count` is also not fast because it needs to evaluate the string then return the number of unique characters.
* Swift does a lot of work on our behalf with strings.

#### Flat app bundles
* When Xcode builds our asset catalog it goes through all  our pictures and optimizes them for iOS devices, then puts the result into a compiled asset catalog that can be loaded efficiently. 
  * As you progress further with asset catalogs you’ll learn that they can handle vector assets, colors, textures, and much more – they are versatile things!
* Loose assets are for all the other kinds of media in our app (text files, JSON, XML, movies, and more)
  * If we have lots we can group then inside Xcode to organize them but at build that goes away. 
  * This is because when we ask the bundle to find the URL for a file it doesn't need to search through all the directories in our app, instead it can look at one place b/c all the files are there
* This is why you can't use the same asset filename twice anywhere in your project. 

### Challenge 
* GOAL: Build an "edutainment" app for kids to help them practice multiplication tables. 
  * Edutainment apps are educational at their code, but ideally have enough playfulness about them to make kids want to play
* Break it down:
  * The player needs to select which multiplication tables they want to practice. 
    * This could be pressing buttons, or it could be an "Up to.." stepper, going from 2 to 12
  * The player should be able to select how many questions they want to be asked: 5, 10, or 20.
  * You should randomly generate as many questions as they asked for, within the difficulty range they asked for. 
* Ideas:
  * If you want to go fully down the “education” route then this is going to be some steppers, a text field and a couple of buttons.
  * Start with an App template, then add some state to determine whether the game is active or whether you’re asking for settings.
  * Generate a range of questions based on the user's settings
  * Show the player how many questions they got correct at the end of the game, then offer to let them play again.
