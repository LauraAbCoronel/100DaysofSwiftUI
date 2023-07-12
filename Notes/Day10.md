# Day 10: Structs, part one
[Link](https://www.hackingwithswift.com/100/swiftui/10)

### How to create your own structs
* Swift’s structs let us create our own custom, complex data types, complete with their own variables and their own functions.
* Structs syntax:
``` swift
struct Album { // struct with the name Album
  let title: String // the constants in the struct (Properties)
  let artist: String
  let year: Int
  
  func printSummary() { // (Method)
    print("\(title) (\(year)) by \(artist)")
  }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012) // this is how we use a struct (Instance)
```
* It's the standard that structs start with a capital letter
* This kinda reminds me of classes
* Things get more interesting is when you want to have values that can change in a struct. 
* When you try to do it, Xcode throws an error. This is because if we create a constant using the struct all variables in the struct become constant
  * The way to fix this is to add the keyword `mutating` in front of the function that is trying to change a variable in the struct like so:
``` swift
struct Employee {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining")
        }
    }
}
```
  * Marking methods as `mutating` will stop the method from being called on constant structs, even if the method itself doesn’t actually change any properties. If you say it changes stuff, Swift believes you!
  * A method that is not marked as mutating cannot call a mutating function – you must mark them both as mutating.
* You get access to the properties in the struct by using the dot notation.
* If you create a constant using the `Employee` struct and try to call the `takeVacation(days:)` function Xcode will throw an error
* Terminology:
  * **Properties**: variables and constants inside a struct
  * **Methods**: The functions inside a struct
  * **Instance**: the variable or constant called/using the struct
  * **Initializer**: The right side of the equation when using a struct
    `let archer // Instance = Employee(name: "Sterling Archer", vacationRemaining: 14) // Initializer` 
* Swift silently creates a special function inside the struct called `init()`, using all the properties of the struct as its parameters.
  * So you can even write an instance like this `var archer = Employee.init(name: "Sterling Archer", vacationRemaining: 14)`
* You can also give the properties a default value by setting it equal to something in the Struct.
  * So in the Initializer you can leave it out or include it if it's a variable in the struct. (You can chang constant values)   
* A benefit to using methods than just using a function is that methods avoid namespace pollution. 
  * Whenever we create a function, the name of that function starts to have meaning in our code. 
  * So, if you write 100 functions you end up with 100 reserved names, and if you write 1000 functions you have 1000 reserved names.

### How to compute property values dynamically
* Structs can have two kinds of property: stored property is a variable or constant that holds a piece of data inside an instance of the struct, and a computed property calculates the value of the property dynamically every time it’s accessed.
* Here's an example of how we can do that
``` swift
struct Employee1 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int { // calculated dynamically
        vacationAllocated - vacationTaken
    }
}
```
* But what if we want to set the value of `vacationRemaining` to a number. We can do this by specifying a getter and setter. 
``` swift
struct Employee1 {
  let name: String
  var vacationAllocated = 14
  var vacationTaken = 0
  
  var vacationRemaining: Int {
    get {
      vacationAllocated - vacationTaken
    }
    
    set {
      vacationAllocated = vacationTaken + newValue
    }
  }
}
```
* the `get` will run when we ask for the `vacationRemaining` and the `set` will run when we assign `vacationRemaining` a value
* `newValue` is a variable Swift creates for us and that represents the value passed when you try to assign `vacationRemaining` a value

### How to take action when a property changes
* Swift lets us create property observers, which are special pieces of code that run when properties change.
  * These take two forms: a `didSet` observer to run when the property just changed, and a `willSet` observer to run before the property changed.
* Here's an example of using `didSet`
``` swift
struct App {
  var contacts = [String]() {
    willSet {
      print("Current value is \(contacts)")
      print("New value will be: \(newValue)")
    }
        
    didSet {
      print("There are now \(contacts.count) contacts")
      print("Old value was: \(oldValue)")
    }
  }
}
```
* In `didSet` if you want the old value, Swift gives you an `oldValue` variable. And a `newValue` for the `willSet`
* Don't put too much work in the `didSet` and `willSet` (property observers)
  * Don't put slow work in there. If you attach a didSet property observer that does all sorts of slow work, then suddenly changing a single integer could take way longer than you expected, and it could cause all sorts of problems for you.

### How to create custom initializers
* You can create your own initializer as long as all properties have a value by the time the initializer ends
* The way to do it is like so:
``` swift
ruct Player {
  let name: String
  let number: Int
    
  init(name:String) { // declare a custom initializer 
    self.name = name // use self to reference the struct's property
    number = Int.random(in: 1...99)
  }
}
```
* You only use self if the parameter label matches the property name
* You can call other methods of the struct inside the initializer BUT you can't do so before assigning values to all of the properties
* You can also create multiple initializers
* Once you create a custom initializer you lose the initializer Swift automatically creates for you
  * If you want it to stay, you need to move the custom initializer to an extension, like so:
``` swift
struct Employee {
  var name: String
  var yearsActive = 0
}

extension Employee {
  init() {
    self.name = "Anonymous"
    print("Creating an anonymous employee…")
  }
}
```
