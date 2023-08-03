# Day 32: Project 6, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/32)

#### Animation: Introduction
* There are a few reasons to use Animations:
  1. It makes our UI look better
  2. Help users understand what's going on with our program
* We're going to look at a range of animations and transitions with SwiftUI

#### Creating implicit animations
* In SwiftUI, the simplest type of animation is an *implicit* one
  * we tell our views ahead of time “if someone wants to animate you, here’s how you should respond”, and nothing more. 
* Our first effect is a button to get bigger and bigger the more you click on it
  * We can do this with the modifier `scaleEffect()`
* You provide `scaleEffect()` a value from 0 up to 1.0.
* Just using it causes it to appear in a bigger size if we want it to animate to a bigger size we have to add a `animation` modifier
``` swift
struct ContentView: View {
	@State private var animationAmount = 1.0
	
    var body: some View {
		Button("Tap Me") {
			animationAmount += 1
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.scaleEffect(animationAmount)
		.animation(.default, value: animationAmount)
    }
}
```
* Implicit animation takes effect on all properties of the view that change, meaning that if we attach more animating modifiers to the view then they will all change together.
  * For example we'll add a `blur` modifier to the button before the `animation` modifier.
* The point is that nowhere have we said what each frame of the animation should look like, and we haven’t even said when SwiftUI should start and finish the animation. Instead, our animation becomes a function of our state just like the views themselves.

#### Customizing animations in SwiftUI
* 

#### Animating bindings
* 

#### Creating explicit animations
* 