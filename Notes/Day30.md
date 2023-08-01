# Day 30: Project 5, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/30)

### Adding to a list of words
* This video we just worked on the UI. 
* We added a TextField that accepts words
  * we learned how to give an onSubmit event to the List so that when any text field is submitted a function will run
* Our function lowercases each word and removes any of the white spaces
  * it also adds a guard that makes sure the word is greater than 1 character
* Oh we also learned about adding withAnimation when you insert a value so that it shows as an animation on the phone
``` swift
withAnimation {
  usedWords.insert(answer, at: 0)
}
```
* To stop the keyboard from auto capitalizing the first word in the text box we added the modifier `textInputAutocapitalization(.never)`
* Oh we also added an SF symbol so that when we display the usedWords a circle with the number of character shows up next to each word. 

### Running code when our app launches
* This video focused on imported our text file with a list of a bunch of 8 letter words
* We learned about `fatalError()`. You call this when an error has a occurred that prevents your app from running. So in our case if they could not find the file in the bundle or the file was corrupt.
* So we made a function to run when the app starts by using the `.onAppear()` modifier 
* And here is how our function looks:
``` swift
func startGame() {
  if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
    if let startWords = try? String(contentsOf: startWordsURL) {
      let allWords = startWords.components(separatedBy: "\n")
      rootWord = allWords.randomElement() ?? "silkworm"
      return
    }
  }
  
  fatalError("Could not load start.txt from bundle.")
}
```

### Validating words with UITextChecker
* We added 4 more functions to help us with word validation.
1. check if they already didn't try this word
2. if the letters in the word they try appear in the root word
3. check if the word is an actual word with spellchecker 
4. change the alerts title and message depending on the title and message string provided. 
* Then we just added them all tho the `addNewWord()` function using `guard`s
