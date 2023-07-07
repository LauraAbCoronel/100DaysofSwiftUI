# Day 5
[Link](https://www.hackingwithswift.com/100/swiftui/5)

### How to check a condition is true or false
* This how an if statement looks like
``` swift
if someCondition {
  print("Do something")
}
```
* We go through a couple of comparison expressions using `<`, `>` and `<=`, `>=`
* Then we go through some equal expression using `==` (if equal) and `!=` (not equal)
* To check if a string is empty we can do 
``` swift
if username == "" {}
// OR
if username.count == 0 {}
// OR
if username.isEmpty {}
```
  * Comparing string against each other isn't fast in any language. But not the case with Swift. 
  * With Swift `.count` is inefficient. 
  * Best way is using `.isEmpty`
* With enum list when comparing if one case is `<` or `>` it checks the order of the case in the enum

### How to check multiple conditions
* if else statement
``` swift
if someCondition {
  print("This will run if the condition is true")
} else {
  print("This will run if the condition is false")
}
```
* else if statement
``` swift
if a {
  print("Code to run if a is true")
} else if b {
  print("Code to run if a is false but b is true")
} else {
  print("Code to run if both a and b are false")
}
```
* To check two conditions in an if statement you can use `&&` to represent AND where both conditions must be true. `||` used for OR where only one needs to be true
  * This is called a logical operator
* Here's an example of how you can use enums in if and else if statements
```swift
if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path")
} else if transport == .car {
    print("Time to get stuck in traffic")
} else {
    print("I'm going to hire a scooter now!")
}
```
  * in the if statement we can just use the dot notation since Swift knows transport is an TransportationOption Data
* If you want to check 3 or more multiple conditions be sure to add parenthesis so Swift knows the comparison order
* You can only compare the same data type. 
  * So you can't compare a Int to a Double

### How to use switch statements to check multiple conditions
* We're going to learn about switch statement
* A nice thing about using switch statement with enums is that Swift throws errors if you have two cases that are the same and if you're missing any case
* Example of a switch case 
``` swift
switch forcast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}
```
* switch must have a case for all possibilities and this is not just for enums. It's for all data types. if you don't you get an error saying "Switch must be exhaustive"
* Swift checks from top down and stop at the first instance.
  * If you do want it to continue you can add `fallThrough` inside the case to tell it to run the next code.
* You can add a default at the bottom of the switch case for a catch all
``` swift
switch place {
  ...
  default: 
    print("Who are you?")
}
```
* Default MUST ALWAYS BE AT THE BOTTOM

### How to use the ternary conditional operator for quick tests
* Ternary operators work with three pieces of input
  * `condition ? trueValue : falseValue`