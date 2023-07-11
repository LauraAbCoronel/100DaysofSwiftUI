# Day 9: Closures
[Link](https://www.hackingwithswift.com/100/swiftui/9)

### How to create and use closures
* You can copy a function by setting it equal to a variable but don't add the parenthesis after the function call
  * `var greetCopy = greetUser` - This copies a function named greetUser and sets it to a variable called greetCopy
* You can also just set a function to a variable when you create the function. Also called as a closure
``` swift
let sayHello = { // you can set a function to a variable
  print("Hi there!")
}
```
* Passing parameters to closures look like so:
``` swift
let sayHello1 = { (name: String) -> String in
  "Hi \(name)!"
}
```
  * The parameter goes inside the curly braces and you use -> as well as an "in" keyword after the return type
  * "in" marks the end of parameters and return type and the start of the body
* So functions are a data type. If we were to set a variable to a function data type it will look like so: `var greetCopy: () -> Void = greetUser`
  * This is saying that greetCopy is a function that takes no parameters and returns nothing
  * you could exchange "Void" for "()"
* Here's another example of copying over a function that takes in an Int and returns a String
  * `let data: (Int) -> String = getUserData`
  * when doing this you lose the parameters label. So when we call the copied function you don't need to use the label like so `let user = data(1989)`
* For all closers parameter labels are NOT a thing. Parameter labels are only used when calling a function directly 
* You don't have to create a closure to pass it to another function. You can just pass it without the parenthesis.
  * `let captialFirstTeam = team.sorted(by: captainFirstSorted)`
* if you have a closer that takes in parameters but does NOT return anything it will look like this
``` swift
let payment = { (user: String) in
    print("Paying \(user)…")
}
```
* And if you have a closer that takes in no parameters but returns something it will look something like this:
``` swift
let payment = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}
```

### How to use trailing closures and shorthand syntax
* When passing a closer to another function you can leave off the types. For our example `.sorted()` must take in a closer with 2 string parameters and return a boolean. So we can simplify it and write:
``` swift
let captainFirstTeam = team.sorted(by: { name1, name2 in
  if name1 == "Suzanne" {
    return true
  } else if name2 == "Suzanne" {
    return false
  }

  return name1 < name2
})
```
* We can actually simplify it ever further by removing "by" and the parenthesis like so:
``` swift
let captainFirstTeam = team.sorted { name1, name2 in
  if name1 == "Suzanne" {
    return true
  } else if name2 == "Suzanne" {
    return false
  }

  return name1 < name2
}
```
* We can simplify it even further by removing the parameters and using the syntax Swift provides. $0 represents the first parameter
``` swift
let captainFirstTeam = team.sorted {
  if $0 == "Suzanne" {
    return true
  } else if $1 == "Suzanne" {
    return false
  }

  return $0 < $1
}
```
* This syntax is good for when your functions are very simple.  
* If we wanted to make a short that does from biggest to smallest it would look something like this
``` swift
let reverseTeam = team.sorted { $0 > $1 }
```


### How to accept functions as parameters
* When you want a parameter to be a function you can just set it's type to `() -> Int`
* you call a function that has a regular parameter and a parameter of a function you can do this.
``` swift
let rolls = makeArray(size: 50) { // makeArray takes in two parameters size and a function
    Int.random(in: 1...20)
}
```
* Here how the shorthand syntax will look if you are calling a function that takes in 3 functions
``` swift
doImportantWork {
  print("This is the first work")
} second: {
  print("This is the second work")
} third: {
  print("This is the third work")
}
```

### Summary: Closers
* You can copy functions in Swift, and they work the same as the original except they lose their external parameter names.
* All functions have types, just like other data types. This includes the parameters they receive along with their return type, which might be `Void` – also known as “nothing”.
* You can create closures directly by assigning to a constant or variable.
* Closures that accept parameters or return a value must declare this inside their braces, followed by the keyword `in`.
* Functions are able to accept other functions as parameters. They must declare up front exactly what data those functions must use, and Swift will ensure the rules are followed.
* In this situation, instead of passing a dedicated function you can also pass a closure – you can make one directly. Swift allows both approaches to work.
* When passing a closure as a function parameter, you don’t need to explicitly write out the types inside your closure if Swift can figure it out automatically. The same is true for the return value – if Swift can figure it out, you don’t need to specify it.
* If one or more of a function’s final parameters are functions, you can use trailing closure syntax.
* You can also use shorthand parameter names such as `$0` and `$1`, but I would recommend doing that only under some conditions.
* You can make your own functions that accept functions as parameters, although in practice it’s much more important to know how to use them than how to create them.

