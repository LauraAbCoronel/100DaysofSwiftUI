# Day 25: Milestone: Projects 1-3
[Link](https://www.hackingwithswift.com/100/swiftui/25)

### What you learned
* Building scrolling forms that mix text with controls such as `Picker`, which SwiftUI turns into a beautiful table-based layout where new screens slide in with fresh choices.
* Creating a `NavigationView` and giving it a title. This not only allows us to push new views onto the screen, but also lets us set a title and avoid problems with content going under the clock.
* How to use `@State` to store changing data, and why it’s needed. Remember, all our SwiftUI views are structs, which means they can’t be changed without something like `@State`.
* Creating two-way bindings for user interface controls such as `TextField` and `Picker`, learning how using `$variable` lets us both read and write values.
* Using `ForEach` to create views in a loop, which allows us to make lots of views all at once.
* Building complex layouts using `VStack`, `HStack`, and `ZStack`, as well as combining them together to make grids.
* How to use colors and gradients as views, including how to give them specific frames so you can control their size.
* How to create buttons by providing some text or an image, along with a closure that should be executed when the button is tapped.
* Creating alerts by defining the conditions under which the alert should be shown, then toggling that state from elsewhere.
* How (and why!) SwiftUI uses opaque result types (`some View`) so extensively, and why this is so closely linked to modifier order being important.
* How to use the ternary conditional operator to create conditional modifiers that apply different results depending on your program state.
* How to break up your code into small parts using view composition and custom view modifiers, which in turn allows us to build more complex programs without getting lost in code.

---

### Key points
#### Structs vs classes
* If you remember, there are five key differences between structs and classes:
  1. Classes don’t come with a memberwise initializer; structs get these by default.
  2. Classes can use inheritance to build up functionality; structs cannot.
  3. If you copy a class, both copies point to the same data; copies of structs are always unique.
  4. Classes can have deinitializers; structs cannot.
  5. You can change variable properties inside constant classes; properties inside constant structs are fixed regardless of whether the properties are constants or variables.
* Whether you choose structs or classes is down to you and the specific problems you’re solving.
* If you use structs most of the time, switching to a class in one particular place conveys some intent: this thing is different and needs to be used differently. If you always use classes, that distinction gets lost – after all, it’s extremely unlikely you need them that often.
* **Tip**: One of the fascinating details of SwiftUI is how it completely inverts how we use structs and classes. In UIKit we would use structs for data and classes for UI, but in SwiftUI it’s completely the opposite – a good reminder of the importance of learning things, even if you think they aren’t immediately useful.

#### Working with ForEach
* Example of `ForEach`
``` swift
ForEach(0 ..< 100) { number in
    Text("Row \(number)")
}
```
* But SwiftUI offers us a second alternative: we can loop over the array directly. This takes a little more thinking, because SwiftUI wants to know how it can identify each item in the array.
  * Think about it: if we loop over a four-item array we will create four views, but if body gets re-invoked and our array now contains five items, SwiftUI needs to know which view is new so it can be shown in the UI.
  * In code we write this
``` swift
VStack {
    ForEach(agents, id: \.self) {
        Text($0)
    }
}
```
* As you progress with SwiftUI we’ll look at a third way of identifying views using the Identifiable protocol, but that will come in time.

#### Working with bindings
* When we use controls such as Picker and TextField we create two-way bindings for them to some sort of @State property using $propertyName.
* you might want something more advanced: what if you want to run some logic to calculate the current value? Or what if you want to do more than just stash away a value when it’s written?
  * This is where custom bindings come in: they can be used just like @State bindings, except we get complete control over how they work.
* First let’s look at the simplest form of custom binding, which just stores the value away in another @State property and reads that back:
``` swift
struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        let binding = Binding(
            get: { selection },
            set: { selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0..<3) {
                    Text("Item \($0)")
                }
            }
            .pickerStyle(.segmented)
        }
    }
}
```
* Notice that the picker is now made using selection: binding – no dollar sign required. We don’t need to explicitly ask for the two-way binding here because it already is one.
* Here's another example of a custom binding that it true if the state is true and sets the 3 states to either true or false
``` swift
let agreedToAll = Binding(
    get: {
        agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
    },
    set: {
        agreedToTerms = $0
        agreedToPrivacyPolicy = $0
        agreedToEmails = $0
    }
)
```

### Challenge
* Make a brain training game that challenges players to win or lose at rock, paper, scissors.
    * Each turn of the game the app will randomly pick either rock, paper, or scissors.
    * Each turn the app will alternate between prompting the player to win or lose.
    * The player must then tap the correct move to win or lose the game.
    * If they are correct they score a point; otherwise they lose a point.
    * The game ends after 10 questions, at which point their score is shown.
* Example: if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.