# Day 23: Project 3, part one
[Link](https://www.hackingwithswift.com/100/swiftui/23)

### Views and modifiers: Introduction
* In our third project we're going to focus in depth on the SwiftUI features.
  * How they work in detail
  * Why they work that way
* We're going to take a closer look at views and view modifiers

### Why does SwiftUI use structs for views?
* The old UIKit and AppKit both used classes instead of structs.
* Reason 1: structs are simpler and faster than classes. 
* In SwiftUI, all our views are trivial structs and are almost free to create.
* Structs contain exactly what you see and nothing more. Classes can inherit things where you don't know what else it includes.
* Classes are able to change their values freely, which can lead to messier code
  * By producing views that don’t mutate over time, SwiftUI encourages us to move to a more functional design approach: our views become simple, inert things that convert data into UI, rather than intelligent things that can grow out of control.
* If you use a class for your view you might find your code either doesn’t compile or crashes at runtime. Trust me on this: use a struct.

### What is behind the main SwiftUI view?
* For SwiftUI developers, there is nothing behind our view.
* Now, right now at least there is something behind our content view called a UIHostingController: it is the bridge between UIKit (Apple’s original iOS UI framework) and SwiftUI. But that might be removed
  * However, if you start trying to modify that you’ll find that your code no longer works on Apple’s other platforms, and in fact might stop working entirely on iOS at some point in the future.
* To allow the text to take up all the space on the screen we can do this:
``` swift
Text("Hello, world!")
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.red)
```
* using `maxwidth` tells it to take all the space it can. 

### Why modifier order matters
* Whenever we apply a modifier to a SwiftUI view, we actually create a new view with that change applied – we don’t just modify the existing view in place.
* Order of modifiers matter. For example the following code doesn't create a red button that's 200 x 200 instead only the text has the background of red
``` swift
struct ContentView: View {
    var body: some View {
		Button("Hello, world") {}
			.background(.red)
			.frame(width: 200, height: 200)
    }
}
```
* Each modifier creates a new struct with that modifier applied, rather than jus setting a property on the view. 
  * Every time we modify a view SwiftUI applies that modifier by using generics: ModifiedContent`<OurThing, OurModifier>`.
  * When we apply multiple modifiers, they just stack up: `ModifiedContent<ModifiedContent<…`

### Why does SwiftUI use "some View" for its view type?
* SwiftUI relies very heavily on a Swift power feature called “opaque return types”, which you can see in action every time you write some View.
  * This means “one object that conforms to the View protocol, but we don’t want to say what.”
* First, using some View is important for performance: SwiftUI needs to be able to look at the views we are showing and understand how they change, so it can correctly update the user interface.
* The View protocol has an associated type attached to it, which is Swift’s way of saying that View by itself doesn’t mean anything – we need to say exactly what kind of view it is.
* Returning View makes no sense, because Swift wants to know what’s inside the view – it has a big hole that must be filled. 
* There are two places where it gets a bit more complicated:
  1. How does VStack work – it conforms to the View protocol, but how does it fill the “what kind of content does it have?” hole if it can contain lots of different things inside it?
  2. What happens if we send back two views directly from our body property, without wrapping them in a stack?
* To answer the first question first, if you create a VStack with two text views inside, SwiftUI silently creates a TupleView to contain those two views – a special type of view that holds exactly two views inside it.
  * And that’s why SwiftUI doesn’t allow more than 10 views inside a parent: they wrote versions of TupleView that handle 2 views through 10, but no more.
* As for the second question, Swift silently applies a special attribute to the body property called @ViewBuilder.
  * This has the effect of silently wrapping multiple views in one of those TupleView containers, so that even though it looks like we’re sending back multiple views they get combined into one TupleView.


### Conditionals modifiers
* It’s common to want modifiers that apply only when a certain condition is met, and in SwiftUI the easiest way to do that is with the ternary conditional operator.
* Below an example of a button that toggles the text color from blue to red
``` swift
struct ContentView: View {
	@State private var useRedText = false
	
    var body: some View {
		Button("Hello, world") {
			useRedText.toggle()
		}
		.foregroundColor(useRedText ? .red : .blue)
    }
}
```
* This is better than just having an if statement that render's different views. Using an if statement is more work for SwiftUI

### Environment modifiers
* Many modifiers can be applied to containers, which allows us to apply the same modifier to many views at the same time.
* For example the following `.font()` modifier applies the font style title to all text views
``` swift
VStack {
  Text("Gryffindor")
  Text("Hufflepuff")
  Text("Ravenclaw")
  Text("Slytherin")
}
.font(.title)
```
* This is called an environment modifier, and is different from a regular modifier that is applied to a view.
* If any of those child views override the same modifier, the child’s version takes priority.
  * For example if we set the first Text view font to be `largeTitle` then only the first title will be large while the others will have the `title` font style
* However not all modifiers are environment modifier.
  * For example if we add a `blur()` modifier to our VStack then try to take the blur effect away from the first Text view it won't let us b/c blur is NOT an environment modifier. Instead it adds to the overall modifier
* There's no way to see what is a environment modifier and what is NOT. You can sometimes tell by the documentation.

### Views as properties
* There are lots of ways to make it easier to use complex view hierarchies in SwiftUI, and one option is to use properties – to create a view as a property of your own view, then use that property inside your layouts.
* Example: 
``` swift
struct ContentView: View {
	let motto1 = Text("Draco dormiens")
	let motto2 = Text("nunquam titillandus")
	
	
    var body: some View {
		VStack {
			motto1
				.foregroundColor(.red)
			motto2
				.foregroundColor(.blue)
		}
    }
}
```
* Creating views as properties can be helpful to keep your body code clearer – not only does it help avoid repetition, but it can also get more complex code out of the body property.
* Swift doesn’t let us create one stored property that refers to other stored properties, because it would cause problems when the object is created. 
  * But you can create your own view
``` swift
struct ContentView: View {
	var motto1: some View {
		Text("Draco dormiens")
	}
  ...
}
```
* If you want to return multiple views you need to either: Use a Stack, use Group, or add `@ViewBuilder` before the `var`
  * Paul prefers to use @ViewBuilder b/c it acts more like body.  

### View composition
* SwiftUI lets us break complex views down into smaller views without incurring much if any performance impact.
* Outside of the `ContentView` struct we can create a struct of our own like this:
``` swift
struct CapsuleText: View {
	var text: String
	
	var body: some View {
		Text(text)
			.font(.largeTitle)
			.padding()
			.foregroundColor(.white)
			.background(.blue)
			.clipShape(Capsule())
	}
}
struct ContentView: View {...}
```
* Now we can use this struct inside our `ContentView` struct. Like so:
``` swift
struct ContentView: View {
    var body: some View {
		VStack(spacing: 10) {
			CapsuleText(text: "First")
			CapsuleText(text: "Second")
		}
    }
}
```

### Custom modifiers
* SwiftUI gives us a range of built-in modifiers, such as font(), background(), and clipShape(). However, it’s also possible to create custom modifiers that do something specific.
* Below is an example of how we would create a custom modifier (it's created outside of our `ContentView`)
``` swift
struct Title: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.foregroundColor(.white)
			.padding()
			.background(.blue)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}
```
* And the way we call it in our struct is like so:
``` swift
Text("Hello, world!")
  .modifier(Title())
```
* When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use.
* For example, we might wrap the Title modifier in an extension such as this (outside of both the Title and ContentView struct):
``` swift
extension View {
	func titleStyle() -> some View {
		modifier(Title())
	}
}
```
* With the extension now we can just call the modifier with `.titleStyle()`
* Custom modifiers can also create new view structure, as needed. 
  * Remember, modifiers return new objects rather than modifying existing ones, so we could create one that embeds the view in a stack and adds another view:
* Here's an example custom modifier that adds a watermark at the bottom right of a view
``` swift
struct Watermark: ViewModifier {
	var text: String
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			
			Text(text)
				.font(.caption)
				.foregroundColor(.white)
				.padding(5)
				.background(.black)
		}
	}
}
```
* **TIP** Often folks wonder when it’s better to add a custom view modifier versus just adding a new method to View, and really it comes down to one main reason: custom view modifiers can have their own stored properties, whereas extensions to View cannot.

### Custom containers
* Although it’s not something you’re likely to do often, I want to at least show you that it’s perfectly possible to create custom containers in your SwiftUI apps.
* This is pretty Advanced
* To try it out, we’re going to make a new type of stack called a GridStack, which will let us create any number of views inside a fixed grid.
* The way you read this: `struct GridStack<Content: View>: View {` is: "there is a new struct called GridStack that conforms to the View protocol. You can provide any kind of content you like, but whatever it is it must conform to the View protocol."
* Below is an example of a custom stack that creates a grid view from 1 view you pass to it
``` swift
struct GridStack<Content: View>: View {
	let rows: Int
	let columns: Int
	@ViewBuilder let content: (Int, Int) -> Content
	
	var body: some View {
		VStack {
			ForEach(0..<rows, id: \.self) {row in
				HStack {
					ForEach(0..<columns, id: \.self) { column in
						content(row, column)
					}
				}
			}
		}
	}
}
```
* Take particular note of the let content line – that defines a closure that must be able to accept two integers and return some sort of content we can show.
* **Tip**: When looping over ranges, SwiftUI can use the range directly only if we know for sure the values in the range won’t change over time. Here we’re using `ForEach` with `0..<rows` and `0..<columns`, both of which are values that can change over time – we might add more rows, for example. In this situation, we need to add a second parameter to `ForEach`, `id: \.self`, to tell SwiftUI how it can identify each view in the loop. We’ll go into more detail on this in project 5.
* And we call it like so 
``` swift
struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Text("R\(row) C\(col)")
        }
    }
}
```
* 