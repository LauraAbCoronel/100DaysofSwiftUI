# Day 1
[Link](https://www.hackingwithswift.com/100/swiftui/1)
### Why Swift?
* Swift launched in 2014 
* SwiftUI launched 2019

### About this course
* Not gonna learn all about Swift but only the important parts

### How to follow along
* Download Xcode
  * To start coding got to File —> New —> Playground
  * Then select macOS and “Blank”
* First time to load up takes awhile 
* All course will use the Playground file

### How to create variables and constants
* `var greeting = “Hello, playground”` 
  * Creates a variable (var = variable)
* `import Cocoa`
  * Brings in a huge collection of code provided by Apple, to make app building easier.
* `let character = “Daphne”`
  * Creates a constant character (Let’s hope this won’t trip me up 😅)
* Swift doesn’t care what you name variables
  * But the tech community uses camelCase 
* Try to use constants over variables
  * This will help Swift to stop you from changing a value

### How to create strings
* You create string by wrapping text in double quotes
* Strings can include:
  * Punctuations
  * Emojis
  * Double quotes (as long as you put \ before it)
* To mark a multiline string it must start and end with 3 double quotes
  * Triple quotes must be on their own line
* `stringName.count`
  * Gives you the length of the string or the number of characters in the string
* `stringName.uppercased()`
  * Returns the string but with the letters uppercased
* `stringName.hasPrefix(“A day”)`
  * Checks if the string starts with "A day" (you can change value in .hasPrefix() for any string
  * Returns a boolean
* `stringName.hasSuffix(“.jpg”)`
  * Checks if the string ends with “.jpg” (you can change value in .hasSuffix() for any string
  * Returns a boolean

### How to store whole numbers
* Creating a Int or whole number is just the same as creating a string
  * `let score = 10`
* If you want to create a big number, instead of using commas like we usually do we can add underscores (_)
  * `let reallyBig = 100_000_000`
  * Swift ignores the underscore
* When doing math on a variable you need to be consistent with the spacing around the modifier 
  * Example `let lowerScore = score-2` works and `score - 2`works but `score -2` does NOT work
* You can check if a number is a multiple of another by using `number.isMultiple(of: 3)` and this checks if number is a multiple of 3

### How to store decimal numbers
* Also known as a floating point number
* This storage method causes decimal numbers to be notoriously problematic for programmers
  * When you print `let number = 0.1 + 0.2` you would expect 0.3 but it s 0.3000….04
* When you create a floating-point number Swift considers it to be a Double
  * Short for double-precision floating-point number
  * Allocates twice the amount of data that older languages might do
* Swift considers these numbers to be different data types than whole numbers (Ints)
* Ints are 100% accurate. 1+2 will always be 3
* Swift won’t let us mix types of data so we can’t do 1 + 2.0. It throws an error
  * To do this you have to convert one of them.
* What ever data type you set it as in the beginning it must stay that type.
  * For example if the variable is a string you can’t make it an Int. Or if the number is an Int you can’t make it a Double
* Many older APIs use a slightly different way of storing decimal numbers, called CGFloat. Fortunately, Swift lets us use regular Double numbers everywhere a CGFloat is expected, so although you will see CGFloat appear from time to time you can just ignore it.
