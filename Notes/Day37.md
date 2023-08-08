# Day 37: Project 7, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/37)

### Building a list we can delete from
* The first steps was to get the UI working. So first we created data to store our expenses.
  * One to store an instance of an expense with: name, type and amount.
  * Then another to contain an array of this struct (a class)
* We saved both of these in their own file.
* In our `ContentView` file we created an instance of our class and used a list to display each in a `ForEach` view.
* We then added a button to our toolbar to add some dummy expense so that we're able to see if our code works.
* We also ended up adding the `.onDelete` modifier to the ForEach so we're able to delete items.

### Working with Identifiable items in SwiftUI
* 

### Sharing an observed object with a new view
* 

### Making changes permanent with UserDefaults
* 

### Final polish
* 