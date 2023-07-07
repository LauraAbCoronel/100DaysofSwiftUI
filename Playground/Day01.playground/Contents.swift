/*
 Code from "How to create variables and constants"
*/
import Cocoa // Bring in collection of code to make app building easier

var greeting = "Hello, playground" // create a variable called greeting

var name = "Ted"
name = "Rebeeca" // variables can be changed
name = "Keeley"

let character = "Daphne" // creates a constant. CANNOT be changed

var playerName = "Roy"
print(playerName) // Print to the console (look below)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

let managerName = "Michael Scott"
let dogBreed = "Samoyed"
let meaningofLife = "How many roads must a man walk down?"

/*
 Code from "How to create strings"
*/

let actor = "Denzel Washington" // creates a regular string
let filename = "paris.jpg" // string can have puncuations
let result = "⭐️ You win! ⭐️" // strings can have emojis

// you can even use double quotes as long as you use a forward slash (\)
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

// creating a multiline string. Triple " must be on their OWN line
let movie = """
A day in
the life of an
Apple engineer
"""

print(actor.count) // prints the length of the string

print(result.uppercased()) // uppercases all letters in the string

print(movie.hasPrefix("A day")) // checks if the string starts with "A day" and returns a boolean
print(filename.hasSuffix(".jpg")) // checks if the string ends with ".jpg" and returns a boolean

/*
 Code from "How to store whole numbers"
*/

let score = 10 // creates an integer
let reallyBig = 100_000_000 // you can add _ in integers and swift ignores them. But this makes it much easier for us to read

let lowerScore = score-2
let higherScore = score + 10
let doubleScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

var counter = 10
counter += 5 // this will add five to counter and save it to conter
print (counter)

counter *= 2 // you can do the same for multiplication, subtraction and division
counter -= 10
counter /= 2

let number = 120
print(number.isMultiple(of: 3)) // checks if 120 is a multiple of 3
print(120.isMultiple(of: 3))

/*
 Code from "How to store decimal numbers"
*/

let numberDouble = 0.1 + 0.2
print(numberDouble) // not 0.3 what we expect

let a = 1
let b = 2.0
let c = a + Int(b) // Swift won't let you add an Int to a Double so you must convert one of them

var name1 = "Nicolas Cage" // name can only be a string you cannot set it as an Int

var rating = 5.0
rating *= 2 // you can multiply a Double by an Int
