# Day 4
[Link](https://www.hackingwithswift.com/100/swiftui/4)

### How to use type annotations
* In the playground we go over all the ways to use type annotations for all data types
  * String, int, double, boolean, array, dictionaries, sets, enums
* When coding Paul likes to use reference types more than type annotations
  * Reference type is where Swift decides what type by the value you set it to. 
* Exception is with constants that we don’t know the value to yet
  * In this exception, Swift doesn’t allow you to use constants before declaring the value and won’t let you change the value once you declare it
* Golden rule:
  * Swift must always know the data type

### Summary: Complex data
* Arrays store many values, and read them using indices
* Dictionaries store many values, and read them using keys we specify
* Sets stores many values, but we don’t choose their order
* Enums create our own types to specify a range of acceptable values
* Swift uses type inference to figure what data we’re storing
* It’s also possible to use type annotation to force a particular type