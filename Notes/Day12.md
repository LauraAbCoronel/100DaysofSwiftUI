# Day 11: Classes
[Link](https://www.hackingwithswift.com/100/swiftui/12)

### How to create your own classes
* Classes is another way to create data types. 
* Similarities between Classes and Structs: 
  1. You get to create and name them 
  2. You can add properties and methods, including property observers and access control.
  3. You can create custom initializers to configure new instances
* Differences between Classes and Structs: 
  1. You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point.
  2. Because of the first point, Swift won't automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all the properties 
  3. When you copy an instance of a class, both copies share the same data - if you change one copy the other one also changes
  4. When the final copy of a class instance is destroyed, Swift can optionally run a special function called deinitializer.
  5. Even if you make a class constant, you can still change its properties as long as they are variables 
* Reason 3 is the most important reason to use Classes in SwiftUI
* Deinitializer allows us to clean up any resources when we no longer need data from a class
* Here's an example syntax of a class:
``` swift
class Game {
  var score = 0 {
    didSet {
      print("Score is now \(score)")
    }
  }
}

var newGame = Game()
newGame.score += 10
```
* It look exactly like a struct. We can even change "class" to "struct" and it works perfectly
* Here are some use cases for classes:
  1. Being able to build one class based on another is really important in Apple’s older UI framework, UIKit, but is much less common in SwiftUI apps. In UIKit it was common to have long class hierarchies, where class A was built on class B, which was built on class C, which was built on class D, etc.
  2. Lacking a memberwise initializer is annoying, but hopefully you can see why it would be tricky to implement given that one class can be based upon another – if class C added an extra property it would break all the initializers for C, B, and A.
  3. Being able to change a constant class’s variables links in to the multiple copy behavior of classes: a constant class means we can’t change what pot our copy points to, but if the properties are variable we can still change the data inside the pot. This is different from structs, where each copy of a struct is unique and holds its own data.
  4. Because one instance of a class can be referenced in several places, it becomes important to know when the final copy has been destroyed. That’s where the deinitializer comes in: it allows us to clean up any special resources we allocated when that last copy goes away.

### How to make one class inherit from another
* To make one class inherit from another, write a colon after the child class’s name, then add the parent class’s name.
* For example if I have a class named Employee I can create another class that inherits from Employee like so:
``` swift
class Developer: Employee { // inherit from Employee which is why they can access hours from Employee
  func work() {
    print("I'm writing code for \(hours) hours.")
  }
}
```
* In the child class we are able to override the methods from the parent component with the `override` keyword like so.
``` swift
class Developer: Employee {
  func work() {
    print("I'm writing code for \(hours) hours.")
  }
  override func printSummary() {
    print("I'm a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing whether code should be indented using tabs or spaces.")
  }
}
```
* Swift will throw an error if you try to override a variable without using the `override` keyword. Swift will also throw an error if you try to override a method that DOES NOT exist in the parent class. 
* If you know your class should NOT have inheritance you can mark it final before `class`. Like so:
``` swift
final class Developer: Employee {
  func work() {
    print("I'm writing code for \(hours) hours.")
  }
  override func printSummary() {
    print("I'm a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing whether code should be indented using tabs or spaces.")
  }
}
```
* This will prevent any class to inherit from this one
* Swift is smart about how method overrides work: if your parent class has a work() method that returns nothing, but the child class has a work() method that accepts a string to designate where the work is being done, that does not require override because you aren’t replacing the parent method.

### How to add initializers for classes
* Class initializers in Swift are more complicated than struct initializers.
* If a child class has any custom initializers, it must always call the parent's initializer after it has finished setting up its own properties.
``` swift
class Car: Vehicle {
  let isConvertible: Bool
  init(isElectric: Bool, isConvertible: Bool) {
    self.isConvertible = isConvertible
    super.init(isElectric: isElectric) // call initializer for the parent
  }
}
```
* `super` is another one of those values that Swift automatically provides for us. It allows us to call up to methods that belong to our parent class, such as its initializer.
* If a subclass does NOT have any of it's own initializers, it automatically inherits the initializers of it's parent class

### How to copy classes
* Classes are reference types
* So if you change the value of one copy it changes the value of another. Like this:
``` swift
var user1 = User()
var user2 = user1
user2.username = "Taylor" // this will change the username for both user1 and user2
```
* If you want to create a unique copy of a class instance - sometimes called a *deep copy* - you need to handle creating a new instance and copy across all your data safely, like so:
``` swift
class User {
  var username = "Anonymous"
  
  func copy() -> User {
    let user = User()
    user.username = username
    return user
  }
}
```
* Now we can safely call copy() to get an object with the same starting data, bua any future changes won't impact the original
``` swift
var user3 = user1.copy()
```

### How to create a deinitializer for a class
* Swift's classes can optionally be given a deinitializer, which gets called when the object is destroyed
* Important things to know
  1. Just like initializers, you don’t use func with deinitializers – they are special.
  2. Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
  3. Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.
  4. We never call deinitializers directly; they are handled automatically by the system.
  5. Structs don’t have deinitializers, because you can’t copy them.
* See code for example

### How to work with variables inside classes
* There are four options our class instance and property be:
  1. Instance: Constant, Property: Constant 
    * Points to the same user, who always has the same data
  2. Instance: Constant, Property: Variable
    * Points to the same user, who's data can change
  3. Instance: Variable, Property: Constant
    * Can point to another user, who always has the same data
  4. Instance: Variable, Property: Variable
    * Can point to another user, who's data can change
* Classes don't need the `mutating` keyword with methods that change their data.

### Summary: Classes
* Classes have lots of things in common with structs, including the ability to have properties and methods, but there are five key differences between classes and structs.
  * First, classes can inherit from other classes, which means they get access to the properties and methods of their parent class. You can optionally override methods in child classes if you want, or mark a class as being `final` to stop others subclassing it.
  * Second, Swift doesn’t generate a memberwise initializer for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the parent class’s initializer at some point.
  * Third, if you create a class instance then take copies of it, all those copies point back to the same instance. This means changing some data in one of the copies changes them all.
  * Fourth, classes can have deinitializers that run when the last copy of one instance is destroyed.
  * Finally, variable properties inside class instances can be changed regardless of whether the instance itself was created as variable.