# Day 29: Project 5, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/29)

### Word Scramble: Introduction
* The next project is another game. 
* The game will show players a random eight-letter word, and ask them to make words out of it.
  * For example, if the starter word is “alarming” they might spell “alarm”, “ring”, “main”, and so on.
* Along the way we'll learn:
  * `List`
  * `onAppear()`
  * `Bundle`
  * `fatalError()`
  * & more
* This will be our last easy project

### Introducing List, your best friend
* `List` is one of the View types that you will rely on the most
  * It provides a scrolling table of data
* Example of how `List` would look:
``` swift
List {
  Text("Static row 1")
  Text("Static row 2")
  ForEach(0..<5) {
    Text("Dynamic row \($0)")
  }
  Text("Static row 3")
  Text("Static row 4")
}
```
* Currently it looks exactly how the `Form` view does
* You can customize the look with the `listStyle()` modifier
*  But one thing `List` can do that `Form` can’t is to generate its rows entirely from dynamic content without needing a `ForEach`.
``` swift
List(0..<5) {
  Text("Dynamic row \($0)")
}
```
* If we wanted to loop through an array with `List`, it would look like this:
``` swift
List(people, id: \.self) {
  Text($0)
}
```
* Shortcut select all then ctrl + I to format the highlighted code

### Loading resources from your app bundle
* When we use Image views, SwiftUI knows to look in your app’s asset catalog to find the artwork, and it even automatically adjusts the artwork so it loads the correct picture for the current screen resolution – that’s the @2x and @3x stuff we looked at earlier.
* But we gotta do more work with text files
* When Xcode builds your iOS app, it creates something called a “bundle”.
  * it allows the system to store all the files for a single app in one place – the binary code (the actual compiled Swift stuff we wrote), all the artwork, plus any extra files we need all in one place.
* All this matters because it’s common to want to look in a bundle for a file you placed there. 
* This uses a new data type called URL, which stores pretty much exactly what you think: a URL
* However, URLs are a bit more powerful than just storing web addresses – they can also store the locations of files, which is why they are useful here.
* If we want to read the URL for a file in our main app bundle, we use `Bundle.main.url()`.
  * If the file exists it will be sent back to us, otherwise we’ll get back nil, so this is an optional URL. That means we need to unwrap it like this:
``` swift
if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
    // we found the file in our bundle!
}
```
* What’s inside the URL doesn’t really matter, because iOS uses paths that are impossible to guess – our app lives in its own sandbox, and we shouldn’t try to read outside of it.
* Once we have a URL, we can load it into a string with a special initializer: `String(contentsOf:)`.
  * We give this a file URL, and it will send back a string containing the contents of that file if it can be loaded.
* This is how we load resources:
``` swift
func loadFile() {
  if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
    // we found the file in our bundle!
    if let fileContents = try? String(contentsOf: fileURL) {
      // we loaded the file into the string
    }
  }
}
```

### Working with strings
* iOS gives us some really powerful APIs for working with strings, including the ability to split them into an array, remove whitespace, and even check spellings.
* In our game we'll be loading a file from our app bundle that contains over 10,000 eight-letter words, which we'll use to start the game.
  * The words are stored by line so we would want to split them up in to an array of strings 
* Swift gives us a method called `components(separatedBy:)` that can converts a single string into an array of strings by breaking it up wherever another string is found.
* For example below separates the string `a b c` to `["a", "b", "c"]`
``` swift
let input = "a b c"
let letters = input.components(separatedBy: " ")
```
* Below is an example of how to separate by line breaks:
``` swift
let input = """
a
b
c
"""
let letters = input.components(separatedBy: "\n")
```
* Another useful string method is `trimmingCharacters(in:)`, which asks Swift to remove certain kinds of characters from the start and end of a string.
  * This uses a new type called `CharacterSet`, but most of the time we want one particular behavior: removing whitespace and new lines – this refers to spaces, tabs, and line breaks, all at once.
  * Example: `let trimmed = letter.trimmingCharacters(in: .whitespacesAndNewlines)` where letter contains a string
* The last functionality we'll cover is the ability to check for misspelled words. 
  * This functionality is provided through the class `UITextChecker`
* the “UI” part of that name carries two additional meanings with it:
  1. This class comes from UIKit. That doesn’t mean we’re loading all the old user interface framework, though; we actually get it automatically through SwiftUI.
  2. It’s written using Apple’s older language, Objective-C. We don’t need to write Objective-C to use it, but there is a slightly unwieldy API for Swift users.
* There are four steps to check for a misspelled word
1. Create a word to check to check and an instance of `UITextChecker` that we can use to check that string
``` swift
let word = "swift"
let checker = UITextChecker()
```
2. Tell checker how much of our string we want to check
  * There’s a catch: Swift uses a very clever, very advanced way of working with strings, which allows it to use complex characters such as emoji in exactly the same way that it uses the English alphabet. **Objective-C does *not*** Which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this: 
``` swift
let range = NSRange(location: 0, length: word.utf16.count) // this says I'm making a range that start at 0 and ends at the length of the string
```
  * UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored; it’s a nice bridging format for us to connect the two.
3. we can ask our text checker to report where it found any misspellings in our word, passing in that range to check, and what language
``` swift
let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
// in is the string we want to check, range is well the range (step 2), starting at: Where should we start in the string, wrap: Should we wrap back to the beginning, language: What language to spell check in
```
  * If it could not find a value we will get NSNotFound returned to us. So to check if there were no spelling errors we can do this:
``` swift
let allGood = misspelledRange.location == NSNotFound
```

* PUT IT ALL TOGETHER
``` swift
func spellCheckWord() {
  let word = "swift"
  let checker = UITextChecker()
  
  let range = NSRange(location: 0, length: word.utf16.count)
  let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
  
  let allGood = misspelledRange.location == NSNotFound
}
```
