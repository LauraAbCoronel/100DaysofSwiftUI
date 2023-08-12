# Day 41: Project 8, part 3
[Link](https://www.hackingwithswift.com/100/swiftui/41)

### Showing mission details with ScrollView and GeometryReader
* In this video created a new view to display the info about each Apollo mission. 
* We created a new file and just filled out the view.
* We used a `GeometryReader` to be able to dictate the `Image` max width in relation to the view's width. 
* Right now we only have a basic layout that displays the mission's image and the highlights.
  *  Next we'll add info about the people who where there.

### Merging Codable structs
* So in this video we added the information for the astronauts.
* in our missions.json file it showed the crew as an array of astronauts and their role 
  * So we created a struct in our `MissionView` to be just that `CrewMember`
```swift
struct CrewMember {
  let role: String
  let astronaut: Astronaut
}
``` 
* We then had to create an init for our `MissionView` that is able to generate the crew information from the missions and astronauts data
```swift
init(mission: Mission, astronauts: [String: Astronaut]) {
  self.mission = mission
  
  self.crew = mission.crew.map { member in
    if let astronaut = astronauts[member.name] {
      return CrewMember(role: member.role, astronaut: astronaut)
    } else {
      fatalError("Missing \(member.name)")
    }
  }
}
```
* So then all we did was add some Views to display the astronauts image, name and role
* We also then linked this view to our `ContentView` so that this view will generate when someone clicks the Apollo mission

### Finishing up with one last view
* The last view we added was the `AstronautView` Where you can see details on each astronaut.
* This is basically just practice of the previous video.
* We added a new file. The view only takes in the astronaut constant
* And displays it on the view.
* Lastly we connected this view to our `MissionView` So that clicking on an astronaut showed you details of them. 