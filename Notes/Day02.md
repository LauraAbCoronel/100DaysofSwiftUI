# Day 2
[Link](https://www.hackingwithswift.com/100/swiftui/2)
### How to store truth with Booleans 
* Store them how you would with any other variable or const
* You can switch between values with either 
  * ! Or toggle()

### How to join strings together 
* One way to add a string is with +
  * The plus being able to add ints and strings is called “Operator Overloading”
    * The ability for one operator such as + to mean different things depending on how it’s used. 
    * This also applies to +=
* Using Plus isn’t that great when you need to add multiple strings. 
  * Swift can’t add them all at the same time. It first needs to add the first two strings then adds the next one. One by one
  * It creates temporary strings which is a waste
* Another way to add strings together is to use string interpolation. 
  * All you have to do is add \() and put the variable in the parenthesis
  * Ex. `print("5 x 5 is \(5 * 5)”)`
* Watch this once I feel good about/understand more of Swift
  * [Super-powered string interpolation in Swift 5.0](https://www.hackingwithswift.com/articles/178/super-powered-string-interpolation-in-swift-5-0)