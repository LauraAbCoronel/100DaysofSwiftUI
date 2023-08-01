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
* 

### Validating words with UITextChecker
* 