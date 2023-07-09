# Day 6: Loops
[Link](https://www.hackingwithswift.com/100/swiftui/6)

### How to use a for loop to repeat work
* Syntax for for loops
``` swift
for item in array { // item is the loop variable
  print("Do repeated code here") // loop body
} 
```
* if an array is plural Xcode has a shortcut to type the for loop. Just write for and start writing the array name and a suggestion pops up. It uses the singular work for the loop variable. 
* Syntax if you want to loop over a set number
``` swift
for i in 1...12 { // i from 1 to 12 including 1 and 12
  print("Do this 1 to 12 times")
}
```
* if you want the range to go up to but not including the last number use ..<
  * 1..<5 goes from 1 to 5 but not including 5
  * this is really useful for arrays (`1..<array.count`)
* If you don't want a loop variable you can just enter an underscore
  * `for _ in 1...5 {}`
* you can actually use the range syntax when you only want certain numbers in an array
  * For example if we have an `name` array with 4 items we can print items 1 to 3 with
    * `print(names[1...3])`
  * But what if we don't know the length then we can do:
    * `print(names[1...])`
* We can learn more about ranges in [this article](https://www.avanderlee.com/swift/ranges-explained/)

### How to use a while loop to repeat work
* Second kind of loop is a while loop
* They aren't as common as for loops
* While loop Syntax
``` swift
while condition {
  // run code while condition is true
}
```
* to get a random number in a range we can use 
  * `Int.random(in: 1...1000)` or `Double.random(in: 0...1)`
  * this includes 1000 and 1

### How to skip loop items with break and continue
* `continue` - continues to the next iteration of the loop
* `break` - breaks out of the loop
* you can actually label our for or while loop so that breaking out of nested loops are easier
``` swift
outerLoop: for option1 in options {
  for option2 in options {
    for option3 in options {
      print("In loop")
      let attempt = [option1, option2, option3]

      if attempt == secretCombination {
        print("The combination is \(attempt)!")
        break outerLoop
      }
    }
  }
}
```

### Summary: Conditions and loops
* We use `if` statements to check a condition is true. You can pass in any condition you want, but ultimately it must boil down to a Boolean.
* If you want, you can add an `else` block, and/or multiple `else if` blocks to check other conditions. Swift executes these in order.
* You can combine conditions using `||`, which means that the whole condition is true if either subcondition is true, or `&&,` which means the whole condition is true if both subconditions are true.
* If you’re repeating the same kinds of check a lot, you can use a `switch` statement instead. These must always be exhaustive, which might mean adding a default case.
* If one of your `switch` cases uses `fallthrough`, it means Swift will execute the following case afterwards. This is not used commonly.
* The ternary conditional operator lets us check WTF: What, True, False. Although it’s a little hard to read at first, you’ll see this used a lot in SwiftUI.
* `for` loops let us loop over arrays, sets, dictionaries, and ranges. You can assign items to a loop variable and use it inside the loop, or you can use underscore, `_`, to ignore the loop variable.
* `while` loops let us craft custom loops that will continue running until a condition becomes false.
* We can skip some or all loop items using `continue` or `break` respectively.