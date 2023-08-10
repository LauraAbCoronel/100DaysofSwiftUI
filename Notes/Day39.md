# Day 39: Project 8, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/39)

### Moonshot: Introduction
* In this project we're going to build an app that lets users learn about the missions and astronauts that formed NASA's Apollo space program.
* We'll start tackling some important SwiftUI problems
  * How can you make an image fit its space correctly?
  * How can we clean up code using computed properties?
  * How can we compose smaller views into larger ones to help keep our project organized.

### Resizing images to fit the screen using GeometryReader
* When we create an `Image` view in SwiftUI, it will automatically size itself according to the dimensions of its contents.
  * So if the picture is 1000x500, the `Image` view will also be that size.
* We're going to learn how to resize an image and how to make it fit some shape.
* If you wnt the image contents to be resized, we need to use the `resizable()` modifier like this
```swift
Image("Example")
  .resizable()
  .frame(width: 300, height: 300)
```
* BUT this will squish the image if the image is not a square
* To fix this we need to resize proportionally which we can do with `scaleToFit()` and `scaleToFill()` modifiers
* This is great if we want the image to be a fixed size but if we want the image to be 80% of the screen then we need to use the `GeometryReader` view.
  * This view gives us a `GeometryProxy` that lets us query environment: how big is the container? What position is our view? Are there any safe area insets?
  * It automatically expands to take up available space in your layout, then positions its own content aligned to the top-left corner. 
```swift
GeometryReader { geo in
  Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: geo.size.width * 0.8, height: 300) // we can even remove height
}
```
* Tip: If you ever want to center a view inside a GeometryReader, rather than aligning to the top-left corner, add a second frame that makes it fill the full space of the container, like this:
```swift
GeometryReader { geo in
  Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: geo.size.width * 0.8)
    .frame(width: geo.size.width, height: geo.size.height)
}
```

### How ScrollView lets us work with scrolling data
* `List` and `Form` lets us create scrolling tables of data, `ScrollView` allows us to create scroll views of anything else
* Here we created a scroll view of text from 0 to 99
```swift
ScrollView {
  VStack(spacing: 10) {
    ForEach(0..<100) {
      Text("Item \($0)")
        .font(.title)
    }
  }
  .frame(maxWidth: .infinity)
}
```
* When we add views to a scroll view, they get created immediately. 
  * If we want to avoid this, we can use `LazyVStack` and `LazyHStack`
* This is more efficient 
* Although the code to use regular and lazy stacks is the same, there is one important layout difference: 
  * lazy stacks always take up as much as room as is available in our layouts, whereas regular stacks take up only as much space as is needed. 
    * This is intentional, because it stops lazy stacks having to adjust their size if a new view is loaded that wants more space.
* One last thing: you can make horizontal scrollviews by passing `.horizontal` as a parameter when you make your `ScrollView`. 
```swift
ScrollView(.horizontal) {
  LazyHStack(spacing: 10) {
    ForEach(0..<100) {
      CustomText("Item \($0)")
        .font(.title)
    }
  }
}
```

### Pushing new views onto the stack using NavigationLink
* We can use `NavigationLink` with any kind of destination view
```swift
NavigationView {
  NavigationLink {
    Text("Detail View")
  } label: {
    Text("Hello, world!")
      .padding()
  }
  .navigationTitle("SwiftUI")
}
```
* You will see that “Hello, world!” now looks like a button, and tapping it makes a new view slide in from the right saying “Detail View”. Even better, you’ll see that the “SwiftUI” title animates down to become a back button, and you can tap that or swipe from the left edge to go back.
* Both `sheet()` and `NavigationLink` allows us to show a new view from the current one but the way is different.
  * `NavigationLink` is for showing details about the user's selection, like you're digging deeper into a topic
  * `sheet()` is for showing unrelated content, such as settings or a compose window
* The most common place you see `NavigationLink` is with a list, and there SwiftUI does something quite marvelous.
* In the following code SwiftUI adds a gray disclosure indicators on the right edge. 
  * This is the standard iOS way of telling users another screen is going to slide in from the right when the row is tapped, and SwiftUI is smart enough to add it automatically here.
```swift
NavigationView {
  List(0..<100) { row in
    NavigationLink {
      Text("Detail \(row)")
    } label: {
      Text("Row \(row)")
    }
  }
  .navigationTitle("SwiftUI")
}
```

### Working with hierarchical Codable data
* The `Codable` protocol makes it trivial to decode flat data.
* In this project we’re going to be decoding slightly more complex JSON: 
  * there will be an array inside another array, using different data types.
* If you want to decode this kind of hierarchical data, the key is to create separate types for each level you have.
```swift
Button("Decode JSON") {
  let input = """
  {
    "name": "Taylor Swift",
      "address": {
        "street": "555, Taylor Swift Avenue",
        "city": "Nashville"
      }
  }
  """
  // more code to come
}
```
* Now for the best part: we can convert our JSON string to the Data type (which is what Codable works with), then decode that into a User instance:
```swift
let data = Data(input.utf8)
let decoder = JSONDecoder()
if let user = try? decoder.decode(User.self, from: data) {
    print(user.address.street)
}
```
* There’s no limit to the number of levels Codable will go through – all that matters is that the structs you define match your JSON string.
```swift
struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}
```

### How to lay out views in a scrolling grid
* SwiftUI’s List view is a great way to show scrolling rows of data, but sometimes you also want columns of data
  * In SwiftUI this is accomplished with two views: `LazyHGrid` for showing horizontal data, and `LazyVGrid` for showing vertical data. 
* Creating a grid is done in two steps. 
  1. First, we need to define the rows or columns we want – we only define one of the two, depending on which kind of grid we want.
```swift
let layout = [
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80))
]
```
  2. Once you have your lay out defined, you should place your grid inside a `ScrollView`, along with as many items as you want. 
* Each item you create inside the grid is automatically assigned a column in the same way that rows inside a list automatically get placed inside their parent.
```swift
ScrollView {
  LazyVGrid(columns: layout) {
    ForEach(0..<1000) {
      Text("Item \($0)")
    }
  }
}
```
* This works but the best part of grids is their ability to work across a variety of screen sizes. 
  *  This can be done with a different column layout using adaptive sizes, like this:
```swift
let layout = [
  GridItem(.adaptive(minimum: 80)),
]
```
  * That tells SwiftUI we’re happy to fit in as many columns as possible, as long as they are at least 80 points in width. You can also specify a maximum range for even more control: