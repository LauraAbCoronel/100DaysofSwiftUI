# Day 31: Project 5, part 3
[Link](https://www.hackingwithswift.com/100/swiftui/31)

### Challenge
1. Disallow answers that are shorter than three letters or are just our start word
* I added a new function that checks the length of the answer is longer than 3 characters.
* I also included an if statement to the `isOriginal` function to check if the word matches the root word
``` swift
func isOriginal(word: String) -> Bool {
  !(usedWords.contains(word) || word == rootWord)
}

func meetsCharacterLength(word: String) -> Bool {
  word.count > 2
}
```

2. Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
* I added the toolbar modifier under the alert modifier. Then I also had the `startGame` function set usedWords to an empty array.
``` swift
.toolbar{
  Button("New Game", action: startGame)
}
```

3. Put a text view somewhere so you can tract and show the player's score for a given root word. How you calculate score is down to you, but something involving number of words and their letter course would be reasonable 
* I added a score state so that when a user enters a valid word I add the number of characters to the score.
* This is a cool way Paul does it:
``` swift
.toolbar{
  Button("New Game", action: startGame)
}
.safeAreaInset(edge: .bottom) {
  Text("Score: \(score)")
}
```
* warning here: before iOS 15.2, SwiftUI’s List view would not actually adjust its inset correctly, which means our score text would hide the bottom rows of the list. From iOS 15.2 and later this is no longer a problem, but be careful!