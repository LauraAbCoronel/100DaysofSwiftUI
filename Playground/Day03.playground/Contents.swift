import Cocoa

/*
 Code from "How to store ordered data in arrays"
*/

var beatles = ["John", "Paul", "George", "Ringo"] // array of strings
let numbers = [4, 8, 15, 16, 23, 42] // array of Ints
var temperatures = [25.3, 28.2, 26.4] // array of decimals/Doubles

print(beatles[0])
print(numbers[1])
print(temperatures[2])

beatles.append("Adrian")

var scores = Array<Int>() // create a blank array of Int
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = [String]() // shorthand way to declare an array
albums.append("Forklore")
albums.append("Fearless")
albums.append("Red")
print(albums.count) // get the length of the array

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2) // removes an item from the array
print(characters.count)

characters.removeAll() // removes all items from the array
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time to Die"]
print(bondMovies.contains("Time")) // checks if the array contains an item. Needs to match exactly

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted()) // sorts an array. For strings alphabetaically, for numbers -inf to inf

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed() // creates a reversed collection
print(Array(reversedPresidents)[0]) // to get an item in the array you need to convert it to an Array first

/*
 Code from "How to store and find data in dictionaries"
*/

let employee = [
    "name": "Taylor Swift", // on the left is called the key and on the right is called a value
    "job": "Singer",
    "location": "Nashville"
]

print(employee["name", default: "Unknown"]) // to get rid of the warning you can give it a default
print(employee["job", default: "Unknown"])
print(employee["location", default: "Unknown"])

let hasGraduated = [ // values can be any data type
    "Eric": false,
    "Maeve": true,
    "Otis": false
]

let olympics = [ // keys can be any data type
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])

var heights = [String: Int]() // create a blank dictionary
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["Lebon James"] = 206

var archEnemies = [String:String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lee Luthor"
archEnemies["Batman"] = "Penguin"

print(archEnemies.count)

/*
 Code from "How to use sets for fast data lookup"
*/

let actors = Set([ // Set will automatically remove any duplicate value from the array and not remember the order
    "Denzel Washington",
    "Tom Cruise",
    "Nicolas Cage",
    "Samuel L Jackson"
])
print(actors) // prints in different order than array and what Paul Hudson shows

var actors1 = Set<String>()
actors1.insert("Denzel Washington") // add an item
actors1.insert("Tom Cruise")
actors1.insert("Nicolas Cage")
actors1.insert("Samuel L Jackson")

print(actors1.contains("Denzel Washington")) // returns true or false
print(actors1.count) // returns the number of items in a set
print(actors1.sorted()) // returns a sorted array

/*
 Code from "How to create and use enums"
*/

enum Weekday { // this is how you declare an enum
    case monday // cannot be a number
    case tuesday
    case wednesday
    case thursday
    case friday
}

enum Weekday1 { //
    case monday, tuesday, wednesday, thursday, friday // you can also separate enums with commas
}

var day = Weekday.monday
day = .tuesday // You don't have to use the enum name next time you change it b/c Swift remembers the enum/data type
day = .friday


