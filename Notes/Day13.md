# Day 13: Protocols and extensions
[Link](https://www.hackingwithswift.com/100/swiftui/13)

### How to create and use protocols
* Protocols let us define what kinds of functionality we expect a data type to support
  * They let us define a series of properties and methods that we want to use.
  * They can be used for structs, classes, and enums
  * Protocols determine the minimum required functionality, but we can always add more.
* A sample protocol snippet
``` swift
protocol Vehicle { // Vehicle is a new type
  // methods and properties we want for this type
  var name: String { get } 
  var currentPassenger: Int { get set }
  func estimateTime(for distance: Int) -> Int 
  func travel(distance: Int)
}
```
* For the properties you do not have to write getters or setters, its just there to let swift know that you can get and/or set the property's value
* When you use a protocol its referred to as:
  * Adopting the protocol or
  * Conforming to the protocol
* Here's an example of how to use protocols
``` swift
struct Car: Vehicle {
  func estimateTime(for distance: Int) -> Int {
    distance / 50
  }
  
  func travel(distance: Int) {
    print("I'm driving \(distance)km")
  }
  
  func openSunroof() {
    print("It's a nice day!")
  }
}
```
* the methods used must be exactly the same. Same name, parameters and types
* A benefit of using protocol is when assigning types to a parameter. We can actually use the protocol type as a parameter type to indicate it has to be an item that conforms to that protocol
``` swift
func commute(distance: Int, using vehicle: Vehicle) { // you can pass any struct that conforms to Vehicle for vehicle parameter
  if vehicle.estimateTime(for: distance) > 100 {
    print("That's too slow! I'll try a different vehicle.")
  } else {
    vehicle.travel(distance: distance)
  }
}
```
* You can conform to as many protocols as you need, just by listing them one by one separated with a comma.
  * If you ever need to subclass something *and* conform to a protocol, you should put the parent class name first, **then** write your protocols afterwards

### How to use opaque return types
* Swift provides one really obscure, really complex, but really important feature called opaque return types, which let us remove complexity in our code.
* First SwiftUI project uses it
* Both Int and Bool conform to a common Swift protocol called Equatable, which means “can be compared for equality.” 
  ``` swift
  func getRandomNumber() -> Int {
    Int.random(in: 1...6)
  } 

  func getRandomBool() -> Bool {
    Bool.random()
  }
  ```
* This video is about returning a protocol
* You can add the keyword `some` before the return type to indicate to Swift that you'll return some type of protocol
* Returning an opaque return type means we still get to focus on the functionality we want to return rather than the specific type
* We can change our function and change the type returned and swift is still happy
``` swift
func getRandomNumber() -> some Equatable {
    Double.random(in: 1...6) // we can change this type and Swift is happy
}
```

### How to create and use extensions
* Extensions let us add functionality to any type, whether we created it or someone else created it – even one of Apple’s own types.
* for example the code below trims out the white spaces and new lines from the ends of a string.
``` swift
var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)
```
* Having to write this everytime we need to is a bit wordy so here's where we can use extensions
* We start with the extension keyword, which tells Swift we want to add functionality to an existing type.
``` swift
extension String {
  func trimmed() -> String {
    self.trimmingCharacters(in: .whitespacesAndNewlines) // returns a new string
  }
}
```
* Here's we're adding a new method to String type called trimmed(), which returns a new string
  * We need to include `self` so that it automatically refers to the current string.
* The benefits of using extension over functions:
  1. When you type `quote.` Xcode brings up a list of methods on the string, including all the ones we add in extensions. This makes our extra functionality easy to find.
  2. Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
  3. Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with `private` access control, for example.
* What’s more, extensions make it easier to modify values in place – i.e., to change a value directly, rather than return a new value.
* Swift's naming guidelines
  * If you're returning a new value rather than changing it in place, you should use the word endings like `ed` or `ing`. 
* example: when we return a new value we used trimmed(), but when we modified the string directly we used trim().
* You can also use extensions to add properties to types, but there is one rule: they must only be computed properties, not stored properties.
  * The reason for this is that adding new stored properties would affect the actual size of the data types
* You can use extension to be able to use the initializer Swift provides and create a new initializer like so 
``` swift
extension Book {
  init(title: String, pageCount: Int) {
    self.title = title
    self.pageCount = pageCount
    self.readingHours = pageCount / 50
  }
}
```

### How to create and use protocol extensions
* Protocols let us define contracts that conforming types must adhere to, and extensions let us add functionality to existing types. But what would happen if we could write extensions on protocols?
* Xcode's playgrounds runs code from top to bottom. In regular project this does not matter
* `Array`, `Set`, and `Dictionary` all conform to a built-in protocol called `Collection`
* Here's an example of extending a protocol
``` swift
extension Collection {
  var isNotEmpty: Bool {
    isEmpty == false
  }
}
```
* By extending the protocol we’re adding functionality that would otherwise need to be done inside individual structs.
  * This is really powerful, and leads to a technique Apple calls protocol-oriented programming (pop)
* we can list some required methods in a protocol, then add default implementations of those inside a protocol extension.
* For example, if we had a protocol like this one:
``` swift
protocol Person {
  var name: String { get }
  func sayHello()
}
```
* Here is saying that all conforming types must add a `sayHello()` method, but we can also add a default `sayHello()` method like so:
``` swift
extension Person {
  func sayHello() {
    print("Hi, I'm \(name)")
  }
}
```
* Now our conforming types *can* add their own `sayHello()` method but they don't need to
* Protocol extensions are used everywhere in Swift, which is why you’ll often see it described as a “protocol-oriented programming language.” 

### Summary: Protocols and extensions
* Protocols are like contracts for code: we specify the functions and methods that we required, and conforming types must implement them.
* Opaque return types let us hide some information in our code. That might mean we want to retain flexibility to change in the future, but also means we don’t need to write out gigantic return types.
* Extensions let us add functionality to our own custom types, or to Swift’s built-in types. This might mean adding a method, but we can also add computed properties.
* Protocol extensions let us add functionality to many types all at once – we can add properties and methods to a protocol, and all conforming types get access to them.