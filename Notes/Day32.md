# Day 32: Project 6, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/32)

### Animation: Introduction
* There are a few reasons to use Animations:
  1. It makes our UI look better
  2. Help users understand what's going on with our program
* We're going to look at a range of animations and transitions with SwiftUI

### Creating implicit animations
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

### Customizing animations in SwiftUI
* The point is that nowhere have we said what each frame of the animation should look like, and we haven’t even said when SwiftUI should start and finish the animation. Instead, our animation becomes a function of our state just like the views themselves.
* Implicit animations always need to watch a particular value 
  * Otherwise animations would be triggered for every small change – even rotating the device from portrait to landscape would trigger the animation, which would look strange.
* We can customize what animation the `animation` modifier uses by swapping out `.default` to any other animation. For example here's and animation with a spring effect
``` swift
var body: some View {
  Button("Tap Me") {
    animationAmount += 1
  }
  .padding(50)
  .background(.red)
  .foregroundStyle(.white)
  .clipShape(Circle())
  .scaleEffect(animationAmount)
  .blur(radius: (animationAmount - 1) * 3)
  .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
}
```
* So the customization part is passing the animation type more properties
* You can also add modifiers to the animation type. For example below adds an delay
``` swift 
.animation(
  .easeInOut(duration: 2)
    .delay(1),
  value: animationAmount
)
```
* We learn about `.repeatCount` and `.repeatForever`
* We also made an animation to an overlay like this:
``` swift
struct CustomizingAnimations: View {
	@State private var animationAmount = 1.0
	
	var body: some View {
		Button("Tap Me") {
//			animationAmount += 1
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.overlay(
			Circle()
				.stroke(.red)
				.scaleEffect(animationAmount)
				.opacity(2 - animationAmount)
				.animation(
					.easeInOut(duration: 2)
						.repeatForever(autoreverses: false),
					value: animationAmount
				)
		)
		.onAppear {
			animationAmount = 2
		}
	}
}
```

### Animating bindings
* The animation() modifier can be applied to any SwiftUI binding, which causes the value to animate between its current and new value.
* So we added a `Stepper` that adjusted the `animationAmount` state but also included an `animation` modifier to it
``` swift
struct AnimationBindings: View {
	@State private var animationAmount = 1.0
	
    var body: some View {
		VStack {
			Stepper(
				"Scale amount",
				value: $animationAmount
					.animation(),
				in: 1...10
			)
			
			Spacer()
			
			Button("Tap Me") {
				animationAmount += 1
			}
			.padding(40)
			.background(.red)
			.foregroundStyle(.white)
			.clipShape(Circle())
			.scaleEffect(animationAmount)
		}
    }
}
```
* We can also add modifier to the binding `animation` modifier like we did in the last video like so:
``` swift
Stepper(
  "Scale amount",
  value: $animationAmount
    .animation(
      .easeInOut(duration: 1)
      .repeatCount(3, autoreverses: true)
    ),
  in: 1...10
)
```
* These binding animations effectively turn the tables on implicit animations: 
  * rather than setting the animation on a view and implicitly animating it with a state change, 
  * we now set nothing on the view and explicitly animate it with a state change. 
* In the former, the state change has no idea it will trigger an animation, and in the latter the view has no idea it will be animated – both work and both are important.

### Creating explicit animations
* You’ve seen how SwiftUI lets us create implicit animations by attaching the animation() modifier to a view, and how it also lets us create animated binding changes by adding the animation() modifier to a binding, but there’s a third useful way we can create animations
* explicitly asking SwiftUI to animate changes occurring as the result of a state change.
* Now, though, we’re being explicit that we want an animation to occur when some arbitrary state change occurs: it’s not attached to a binding, and it’s not attached to a view, it’s just us explicitly asking for a particular animation to occur because of a state change.
* We're going to make the button have a 3D spin effect when it's tapped. 
  * We're going to use the `rotation3DEffect()` modifier to do so. 
* if we use a withAnimation() closure then SwiftUI will ensure any changes resulting from the new state will automatically be animated. So this is how it would look
``` swift
struct ExplicitAnimations: View {
	@State private var animationAmount = 0.0
	
    var body: some View {
		Button("Tap Me") {
			withAnimation {
				animationAmount += 360
			}
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.rotation3DEffect(
			.degrees(animationAmount), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
		)
    }
}
```
* And if we want to customize the explicit animation we do so like this:
``` swift
withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
  animationAmount += 360
}
```