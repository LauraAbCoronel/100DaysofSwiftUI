# Day 8: Functions, part two
[Link](https://www.hackingwithswift.com/100/swiftui/8)

### How to provide default values for parameters
* To give a parameter a default value you just write `= value` after the parameter name
``` swift
func printTimesTables(for number: Int, end: Int = 12) {...} // here the end parameter has a default value of 12
```
* When creating an array Swift gives arrays just enough memory to hold their items plus a little extra to grow
  * If more items are added to the array, Swift allocates more and more memory automatically, so that as little as possible is wasted.
* When we call `removeAll()` Swift will automatically remove all items and free up all the memory. 
  * But sometimes you might know you need to add a lot of items again therefore you can pass `removeAll()` a parameter to keep the capacity.

### How to handle errors in functions
* Handling functions takes three steps
  1. Telling Swift about the possible errors that can happen
  2. Writing a function that can flag up errors if they happen
  3. Calling that function, and handling any errors that might happen.
* In the code we use an enum and set the data type to `Error`
* If a function is able to throw errors you must mark it with `throws` keyword before the return type
``` swift
func checkPassword(_ password: String) throws -> String { // mark function with throw
    if password.count < 5 { throw PasswordError.short} // use throw to throw an error type
    if password == "12345" { throw PasswordError.obvious}
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}
```
  * this means that it can throw errors but it doesn't have to.
*  Here's some sudo code that handle errors in functions
``` swift
do {
  try someRiskyWork()
} catch {
  print("Handle errors here")
}
```
* `try` must be written before all throwing functions 
* `try` must be inside a `do` block but in some cases you can use `try!` which does NOT require `do` or `catch`
  * This basically says that you think that this function will not throw an error so we don't need to check for it
  * But if there is an error then swift will crash
* if you want to write a catch block for a specific error then you write a new catch block with the error type next to it
``` swift
do {
  // try some function
} catch checkPassword.short {}
```
* if your function throws an error Apple created we can print that by using `error.localizedDescription`
``` swift
do {
    let result = try checkPassword(string) // try must be written before all throwing functions
} catch {
    print("There was an error: \(error.localizedDescription)")
}
```
* If your function might encounter errors you don't have to create a throwing function. Sometimes your function can just handle the error in the function. 
* Further reading if wanted : [Using try catch in Swift](https://www.donnywals.com/working-with-throwing-functions-in-swift/)

### Summary: Functions
* Functions let us reuse code easily by carving off chunks of code and giving it a name.
* All functions start with the word `func`, followed by the function’s name. The function’s body is contained inside opening and closing braces.
* We can add parameters to make our functions more flexible – list them out one by one separated by commas: the name of the parameter, then a colon, then the type of the parameter.
* You can control how those parameter names are used externally, either by using a custom external parameter name or by using an underscore to disable the external name for that parameter.
* If you think there are certain parameter values you’ll use repeatedly, you can make them have a default value so your function takes less code to write and does the smart thing by default.
* Functions can return a value if you want, but if you want to return multiple pieces of data from a function you should use a tuple. These hold several named elements, but it’s limited in a way a dictionary is not – you list each element specifically, along with its type.
* Functions can throw errors: you create an enum defining the errors you want to happen, throw those errors inside the function as needed, then use `do`, `try`, and `catch` to handle them at the call site.