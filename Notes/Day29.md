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
* 