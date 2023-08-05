# Day 34: Project 6, part 3
[Link](https://www.hackingwithswift.com/100/swiftui/34)

### Challenge
1. When you tap a flag, make it spin around 360 degrees on the Y axis.
* I over thought this alot! I kinda blame Gustavo lol he recommended commenting out the flagTapped function 
* The solution was to create a state that tracks which flag was tapped with the initial value set to -1. Then if the Flag was tapped set the value to that int. 
  * Lastly we added the rotation and the animation
``` swift
@State private var selectedFlag = -1
// ... more code

FlagImage(name: countries[number])
  .rotation3DEffect(
    .degrees(selectedFlag == number ? 360 : 0),
    axis: (x: 0.0, y: 1.0, z: 0.0)
  )
  .animation(.default, value: selectedFlag)
```

2. Make the other two buttons fade out to 25% opacity.
* To solve this we just added an opacity modifier like this right before the animation 
``` swift
.opacity((selectedFlag == -1 || selectedFlag == number) ? 1 : 0.25)
```

3. Add a third effect of your choosing to the two flags the user didn't choose - maybe make them scale down? Or flip in a different direction? Experiment!
* I added two effect the scale and saturation
``` swift
.scaleEffect((selectedFlag == -1 || selectedFlag == number) ? 1 : 0.75)
.saturation((selectedFlag == -1 || selectedFlag == number) ? 1 : 0)
```