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
* 

### Showing and hiding views with transitions
* 

### Building custom transitions using View Modifier
* 