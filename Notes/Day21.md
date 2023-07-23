# Day 21: Project 2, part two
[Link](https://www.hackingwithswift.com/100/swiftui/21)

### Stacking up buttons
* We start the video off by downloading the images of some flags and saving them into our project's `Assets.xcassets` file.
// I wish he explained more how Xcode got access to the images in our assets folder. Like how did it know to pull up the flag from giving it the string from the array we made.
* We added the basic UI. The flags on the screen and the prompt is generated

### Showing the player's score with an alert
* In order for this game to be fun, we need to randomize the order in which flags are shown
* To have the flags show up different each time we can shuffle the `countries` array when the game starts by adding `.shuffled()` to the end of the array
* Now we add some functionality to our app. We have two states that store if we're showing the score and the title (If they answered right or wrong)
* We're using an alert to show the user if they got it right or wrong

### Styling our flags
* Our game works but we're going to update our design
* We update our background color to be a gradient instead of a solid blue color
* We also update the fonts for our text
  * Making the instruction step a subheadline and a heavy weight
  * The Country text a large title font (Which is the largest built-in font size in iOS). This will automatically scale up or down depending on what setting the user has on their fonts
* We then change the shape of our flag image to Capsule so it kinda looks like a pill and give it a shadow

### Upgrading our design
* We changed up how our background looks
* We also gave our VStack of our game some background so it stands out
* We just makes some adjustment to spacing
* We also add a title and score display