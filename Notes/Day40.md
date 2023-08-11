# Day 40: Project 8, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/40)

#### Loading a specific kind of Codable data
* So this video was all about loading in the data. 
* So first we created a struct that will hold our astronaut's data (id, name, description)
```swift
struct Astronaut: Codable, Identifiable {
	let id: String
	let name: String
	let description: String
}
```
* We then created a method to handle grabbing our data
  * We actually made this method an extension of Bundle.
```swift
extension Bundle {
	func decode(_ file: String) -> [String: Astronaut] {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}
		
		let decoder = JSONDecoder()
		
		guard let loaded = try? decoder.decode([String:Astronaut].self, from: data) else {
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		return loaded
	}
}
```
* We did it this way so that when we created the list of astronauts we just had to write one line of code. 
```swift
let astronauts = Bundle.main.decode("astronauts.json")
```

### Using generics to load any kind of Codable data
* In this video we improved our `decode` method that we wrote in the last video.
* Currently the method only decodes to Astronauts BUT we want it to decode Mission data too.
* So what we did is learn about generics.
  * Generics lets us say the type that is returned is some type that conforms to `Codable`. 
* Now with the code below we can decode any type of data
```swift
extension Bundle {
	func decode<T: Codable>(_ file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}
		
		let decoder = JSONDecoder()
		
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		return loaded
	}
}
```
* The only difference is that when we call the decode method we need to specify the type that the variable is like this:
```swift
let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
```

### Formatting our mission view
* This video was a big one. 
* The first thing we tackled is to add some computed variables in Mission to get the displayName and the image name
```swift
var displayName: String {
    "Apollo \(id)"
}

var image: String {
    "apollo\(id)"
}
```
* We then started implementing the UI by adding a scroll view and a lazyVGrid. You can see how it looks in the app
* The way the date came is is a little funky with Year, Month, Day. So we decided to format it.
* The first thing we did is to tell the `JSONDecoder` what the `dateDecodingStrategy` is. 
  * This is now we did it
```swift
let formatter = DateFormatter()
formatter.dateFormat = "y-MM-dd" // format our date is in
decoder.dateDecodingStrategy = .formatted(formatter)
```
* This is great then we had to update the date time in our missions struct to be `Date?` NOT `String?`
  * But this caused some compiling error in our `ContentView`. The text view attempts to use an optional `Date` then the nil coalescent sets it to a string.
* So to fix this we added another computed variable to format the date string, like so:
```swift
var formattedLaunchDate: String {
    launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
}
```
* Lastly was improving the UI Coloring. So first we created a new theme.
  * There's two ways of doing this in the Asset file OR as an `extension` to the `ShapeStyle`
* We decided to do the latter. and came up with this:
```swift
// extend to ShapeStyle only when it's being used as a color
extension ShapeStyle where Self == Color { 
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
``` 
* We then implemented this color and added some more padding and styling
* We also set our app's preferred color scheme to dark mode
```swift
.preferredColorScheme(.dark)
```
