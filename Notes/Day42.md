# Day 42: Project 8, part 4
[Link](https://www.hackingwithswift.com/100/swiftui/42)

### Challenge
1. Add the launch date to `MissionView`, below the mission badge. You might choose to format this differently given that more space is available, but it’s down to you.
* I just added a text view under the "Mission Highlights" Section
```swift
Text("Launch Date: \(mission.formattedLaunchDate) \n")
```

2. Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in `MissionView` is a great candidate, but if you followed my styling then you could also move the `Rectangle` dividers out too.
* I moved the Astronaut List View into it's own file. The only hiccup I'm having is how to fix the preview since `MissionView`'s init creates the crew array.

3. For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
```swift

```