# Day 33: Project 6, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/33)

### Controlling the animation stack
* So, the order in which we apply animations matters: only changes that occur before the animation() modifier get animated.
* If we apply multiple animation() modifiers, each one controls everything before it up to the next animation.
* If we apply multiple animation() modifiers, each one controls everything before it up to the next animationf we apply multiple animation() modifiers, each one controls everything before it up to the next animation
``` swift
Button("Tap Me") {
    enabled.toggle()
}
.frame(width: 200, height: 200)
.background(enabled ? .blue : .red)
.animation(nil, value: enabled)
.foregroundColor(.white)
.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
.animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
```
* That kind of control wouldn’t be possible without multiple `animation()` modifiers – if you tried to move `background()` after the animation you’d find that it would just undo the work of `clipShape()`.

### Animating gestures
* We start the video off by making a card that we can drag around the screen, but when we let go it snaps back into its original location.
* To allow something to be able to move around the screen based on the location of our finger, requires 3 steps
  1. Create a state to store amount of their drag:
``` swift
@State private var dragAmount = CGSize.zero
```
  2. Use that size to influence the card's position on-screen, by using the `offset()` modifier
``` swift
.offset(dragAmount)
```
  3. Create a `DragGesture` and attach it to the card. Also attach 2 modifiers `.onChanged()` and `onEnded()`
    - `.onChanged()`: Run a closure whenever the user moves their finger
    - `onEnded()`: Run a closure when the user lifts their finger off the screen, ending the drag
    - Both closures are given a single parameter
``` swift
.gesture(
    DragGesture()
        .onChanged { dragAmount = $0.translation } // translation is the location from origin
        .onEnded { _ in dragAmount = .zero }
)
```
* Now to add an animation we have two options: add an implicit animation that will animate the drag and the release, or add an explicit animation to animate just the release.
  * The implicit we would add the following to the LinearGradient. This will cause a lag while dragging b/c Swift is adding an animation
``` swift
.animation(.spring(), value: dragAmount)
```
  * The explicit would look like the following. This will NOT have a lag while dragging
``` swift
.onEnded { _ in
  withAnimation {
    dragAmount = .zero
  }
}
```
* Here's how our first animation was coded. 
``` swift
LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
  .frame(width: 300, height: 200)
  .clipShape(RoundedRectangle(cornerRadius: 10))
  .offset(dragAmount)
  .gesture(
    DragGesture()
      .onChanged { dragAmount = $0.translation }
      .onEnded { _ in
        withAnimation {
          dragAmount = .zero
        }
      }
  )
//			.animation(.spring(), value: dragAmount) // implicit
```
* Next we're going to write "Hello SwiftUI" as a series of individual letters, each one with a background color and offset that is controlled by some state 
* We did so with this:
``` swift
HStack(spacing: 0) {
  ForEach(0..<letters.count, id: \.self) { num in
    Text(String(letters[num]))
      .padding(5)
      .font(.title)
      .background(enabled ? .blue : .red)
      .offset(dragAmount)
      .animation(.default.delay(Double(num) / 20), value: dragAmount)
    
  }
}
.gesture(
  DragGesture()
    .onChanged { dragAmount = $0.translation}
    .onEnded { _ in
      dragAmount = .zero
      enabled.toggle()
    }
)
```

### Showing and hiding views with transitions
* 

### Building custom transitions using View Modifier
* git 