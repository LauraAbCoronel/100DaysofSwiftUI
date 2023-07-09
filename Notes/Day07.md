# Day 7: Functions, part one
[Link](https://www.hackingwithswift.com/100/swiftui/7)

### How to reuse code with functions
* Syntax for a function that does NOT return anything
``` swift
func funcName() {} 
```
* to add a parameter, in the parenthesis write the parameter name and give it a Data Type like so: 
``` swift
func printTimesTables(number: Int) {}
```
  * and when you call it you have to use the argument name like so `printTimesTables(number: 5)` 
* You must pass in arguments in the order they appear in the function
* Swift lets you build new functions out of existing functions, which is a technique called function composition

### How to return values from functions
* On function that the `import Cocoa` brings in is `sqrt()` which returns the square root of a number
* Syntax for a function that returns a value
``` swift
func funcName() -> dataType { // dataType is the data type of the returned value
  return varName
} 
```
* If the body of the function is only 1 line of code and is an expression (it returns something) you can remove the `return` keyword
* Even if the function doesn't return anything you can still use `return` to force the function to stop running

### How to return multiple values from functions
* When returning multiple values it's best to use tuples
* Tuples look like this `(firstName: "Taylor", lastName: "Swift")`
* and to get access to them you use dot notation (`user.firstName`)
* Tuples is best b/c
  * Swift can't know ahead of time if dictionary keys are present
  * When you access tuple values, Swift knows it will be there
  * We access values using user.firstName, not a string
  * Dictionary might contain hundreds of other values
  * When you return stuff in tuple you don't have to use the name because Swift knows it from the return data type. Ex `("Taylor", "Swift")`
  * You can also just not give each tuple value a key and use numbers to get the value
``` swift
func getUser() -> (String, String) { 
  ("Taylor", "Swift")
}

let user = getUser()
print("Name: \(user.0) \(user.1)") // read the value starting at 0
```
  * When getting a tuple from calling a function, you can use destructuring to separate the values in two variables
  `let (firstName, lastName) = getUser()`
    * actually if you don't need one of the values you can replace it with an underscore (`_`)
    `let (firstName, _) = getUser()`

### How to customize parameter labels
* You can have functions with the same name but as long as they have different parameter names!
* You can also give parameter's two names one to use in the function and one to use when the function is called. And for the second one we could use an underscore (`_`) so that when we call it we don't need to use the parameter name
``` swift
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
isUppercase("HELLO")
```
* 