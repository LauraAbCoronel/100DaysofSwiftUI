# Day 10: Structs, part two
[Link](https://www.hackingwithswift.com/100/swiftui/11)

### How to limit access to internal data using access control
* By default, Swift's structs let us access their properties and methods freely, but often that isn't what you want
* To not allow people to access a property, all we need to do is add `private` keyword before `var` or `let`
* How to limit access to internal data using access control
  * `private`: Don't let anything outside the struct use this
  * `fileprivate`: Don't let anything outside the current file use this
  * `public`: Let anyone, anywhere use this
  * `private(set)`: Allows people to read the value but they cannot manipulate the value outside the struct
* If you limit access to internal data there's a good possibility that you will need to create your own initializer
  * Even if you set a default value
* Apple's Documentation on [Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/)

### Static properties and methods
* Sometimes you want to add a property or method to the struct itself, rather than to one particular instance of the struct, which allows you to use them directly.
* Simple example:
``` swift
struct School {
  static var studentCount = 0

  static func add(student: String) {
    print("\(student) joined the school.")
    studentCount += 1
  }
}
```
* The `static` keyword means both the `studentCount` property and `add()` method belong to the School struct itself.
* So rather can creating an instance we can add a student like so
``` swift
School.add(student: "Taylor Swift")
print(School.studentCount)
```
* Noticed that we didn't need to add the `mutating` keyword, that's because it's only needed with regular struct functions for times when an instance of struct was created as a constant. In our case there is NO instance when calling `add()`
* If you want to mix and match static and non-static properties and methods, there are two rules:
  1. To access non-static from static code ... you're out of luck 
  2. To access static code from non-static code, always use your type's name such as `School.studentCount`. You can also use `Self.studentCount` to refer to the current type *I wish he showed an example of this*
* `self` and `Self` are different
  * `self`: The current value of a struct (ex. 55. "Hello", true)
  * `Self`: The current type of struct (ex. Int, String, Bool)
* Example of how to manipulate static code from non-static code
``` swift
struct LegoBrick {
	static var numberMade = 0
	var shape: String
	var color: String
	init(shape: String, color: String) {
		self.shape = shape
		self.color = color
		LegoBrick.numberMade += 1
	}
}
```

### Summary: Structs
* You can create your own structs by writing struct, giving it a name, then placing the struct’s code inside braces.
* Structs can have variable and constants (known as properties) and functions (known as methods)
* If a method tries to modify properties of its struct, you must mark it as mutating.
* You can store properties in memory, or create computed properties that calculate a value every time they are accessed.
* We can attach didSet and willSet property observers to properties inside a struct, which is helpful when we need to be sure that some code is always executed when the property changes.
* Initializers are a bit like specialized functions, and Swift generates one for all structs using their property names.
* You can create your own custom initializers if you want, but you must always make sure all properties in your struct have a value by the time the initializer finishes, and before you call any other methods.
* We can use access to mark any properties and methods as being available or unavailable externally, as needed.
* It’s possible to attach a property or methods directly to a struct, so you can use them without creating an instance of the struct.