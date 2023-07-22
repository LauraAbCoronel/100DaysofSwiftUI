# Day 20: Project 2, part one
[Link](https://www.hackingwithswift.com/100/swiftui/20)

### Guess the Flag: Introduction
* Our next project is a guessing game that helps users learn some of the many flags of the world
* In this project we'll learn how to use: stacks, buttons, images, alerts, asset catalogs, and more.

### Using stacks to arrange views
* When we return some View for our body, SwiftUI expects to receive back some kind of view that can be displayed on the screen.
* If we want to return multiple things we have various options, but three are particularly useful.
  * `HStack`
  * `VStack`
  * `ZStack`
* If you try to return two text views it doesn't work as you expect it to.
* When you use `VStack` they will lay the text on top of one another. But if you want to add some spacing between you can pass it to `VStack` like so:
``` swift
VStack(spacing: 20) {
  Image(systemName: "globe")
    .imageScale(.large)
    .foregroundColor(.accentColor)
  Text("Hello, world!")
}
```
* By default `VStack` is center aligned but you can pass `alignment` in the same place we put `spacing` and we can change the alignment
* You can add `Spacer` views to your VStack to push the rest of your contents up or down. 
* You can even add multiple `Spacer` views and Swift will divide the empty space evenly
* With `ZStack` the first view you place goes to the bottom and the rest gets written on top


### Colors and frames
* SwiftUI gives us a range of functionality to render colors, and manages to be both simple and powerful – a difficult combination, but one they really pulled off.
* You can give a view a background color by adding `.background(.red)` to the bottom of the view, like so:
``` swift
ZStack {
    Text("Your content")
}
.background(.red)
```
* But that only makes the text's background color red. If we wanted to make the whole background color red we can use a color view like so
``` swift
ZStack {
  Color.red
  Text("Your content")
}
```
* Since that is a view you can also use modifiers to it. For example the `frame()` modifier allows you to specify the width and height of the Color
``` swift
Color.red
  .frame(width: 200, height: 200)
```
* As you may have guessed you can give Color a bunch of different colors like `.green`, `.indigo`. 
* But you can also use semantic colors; colors that don't say what hue they contain but instead describe their purpose.
  * For example `Color.primary` is the default color of text in SwiftUI, and will either be black or white depending on whether the device is running in light or dark mode
* `Color.secondary` is similar to `Color.primary` but its transparent. If we add a color behind it, it will change the hue.
* If you want to specify the color you can like so:
``` swift
Color(red: 1, green: 0.8, blue: 0)
```
* All of these colors left some white space at the top where the notch is and at the bottom. Where the rounded corners are.
  * The area that has the color is called the safe area b/c we won't lose anything b/c of the rounded colors or the notch at the top
* You can ignore safearea by adding the `ignoreSafeArea()` modifier to the view
* You can also use modifiers to give your view a material type of look. Like for the example below, the text box has a background but it's thin so some of the red and blue show through.
``` swift
ZStack {
  VStack(spacing: 0) {
    Color.red
    Color.blue
  }
  Text("Your Content")
    .foregroundColor(.secondary)
    .padding(50)
    .background(.ultraThinMaterial)
}
```

### Gradients
* Swift gives us three kinds of gradients to work with, and like colors they are also views that can be drawn in our UI.
* Gradients are made up of several components:
  * An array of colors to show
  * Size and direction information
  * Type of gradient to use
* For exmaple here's a linear gradient
``` swift
LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
```
* The inner Gradient type used there can also be provided with gradient stops, which let you specify both a color and how far along the gradient the color should be used.
* For example below specifies a gradient that should be white 45% of the available space and then black from 55% onwards:
``` swift
LinearGradient(gradient: Gradient(stops: [
    Gradient.Stop(color: .white, location: 0.45),
    .init(color: .black, location: 0.55), // a shortcut you can use .init instead of Gradient.Stop since Swift knows its a stop
]), startPoint: .top, endPoint: .bottom)
```
* As an alternative, radial gradients move outward in a circle shape, so instead of specifying a direction we specify a start and end radius – how far from the center of the circle the color should start and stop changing. For example:
``` swift
RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
```
* The last gradient type is called an angular gradient, although you might have heard it referred to elsewhere as a conic or conical gradient. This cycles colors around a circle rather than radiating outward, and can create some beautiful effects.
``` swift
AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
```
* All of these gradient types can have stops provided rather than simple colors. Plus, they can also work as standalone views in your layouts, or be used as part of a modifier – you can use them as the background for a text view, for example.

### Buttons and images
* We covered buttons very briefly but they can do much cooler things
* You can pass a function to a button so that it calls the function like so
``` swift
struct ContentView: View {
  var body: some View {
    Button("Delete selection", action: executeDelete)
  }

  func executeDelete() {
    print("Now deleting…")
}
}
```
* We can customize how a button looks. One example is to give a button a role argument like so:
``` swift
Button("Delete selection", role: .destructive, action: executeDelete)
```
* This adjust its appearance both visually and for screen readers.
* Second, we can use one of the built-in styles for buttons: .bordered and .borderedProminent. These can be used by themselves, or in combination with a role:
``` swift
VStack {
    Button("Button 1") { }
        .buttonStyle(.bordered)
    Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)
    Button("Button 3") { }
        .buttonStyle(.borderedProminent)
        .tint(.mint) // change color
    Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)
}
```
* `.bordered` give it a button with a background
* `.borderedProminent` give the button a color so blue or red
  * ONLY use for 1 or 2 buttons
* But you can also just tell it the color with the `.tint()` modifier 
* If you want something completely custom, you can pass a custom label using a second trailing closure:
``` swift
Button {
  print("Button was tapped")
} label: {
  Text("Tap me!")
    .padding()
    .foregroundColor(.white)
    .background(.red)
}
```
* This is common when we want to incorporate images into the buttons.
* SwiftUI has a dedicated Image type for handling pictures in your apps, and there are three main ways you will create them:
  * `Image("pencil")` will load an image called “Pencil” that you have added to your project.
  * `Image(decorative: "pencil")` will load the same image, but won’t read it out for users who have enabled the screen reader. This is useful for images that don’t convey additional important information.
  * `Image(systemName: "pencil")` will load the pencil icon that is built into iOS. This uses Apple’s SF Symbols icon collection, and you can search for icons you like – download Apple’s free SF Symbols app from the web to see the full set.
* By default the screen reader will read your image name if it is enabled, so make sure you give your images clear names if you want to avoid confusing the user.
* Here is an example of a edit button that looks like a pencil
``` swift
Button {
    print("Edit button was tapped")
} label: { 
    Image(systemName: "pencil")
}
```
* And if we wanted some text next to the image we would just replace `Image` with `Label` and add the text as the first argument like so: `Label("Edit", systemImage: "pencil")`
* when we use a label it will automatically decide whether to show the icon, the text, or both depending on how they are being used in our layout. This makes Label a fantastic choice in many situations, as you’ll see.
* TIP
  * If you find that your images have become filled in with a color, for example showing as solid blue rather than your actual picture, this is probably SwiftUI coloring them to show that they are tappable. To fix the problem, use the renderingMode(.original) modifier to force SwiftUI to show the original image rather than the recolored version.

### Showing alert messages
* The ways alerts work are interesting. So, rather than saying “show the alert”, we instead create our alert and set the conditions under which it should be shown.
* We start off by creating some state that tracks whether our alert is showing like so: `@State private var showingAlert = false`
* You then attach your alert somewhere to our UI, telling it to use that state to determine whether the alert is present or not
* Putting that all together, here’s some example code that shows an alert when a button is tapped:
``` swift
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) { // first part is the alert title
            Button("OK") { } // we can add additional functionality but SwiftUI automatically sets showingAlert to false
        }
    }
}
```
* This attaches the alert to the button, but it doesn't matter where the alert() modifier is used. all we’re doing is saying that an alert exists and is shown when showingAlert is true.
* SwiftUI will automatically set showingAlert back to false when the alert is dismissed.
* You can also give the alert a message by chaining message to alert like so:
``` swift
var body: some View {
    Button("Show Alert") {
        showingAlert = true
    }
    .alert("Important message", isPresented: $showingAlert) {
        Button("Delete", role: .destructive) {}
        Button("Cancel", role: .cancel) { }
    } message: {
        Text("Please read this")
    }
}
```