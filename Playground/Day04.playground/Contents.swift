import Cocoa

/*
 Code for "How to use type annotations
*/

let surname: String = "Lasso"
var score: Double = 0

// below list all the data types
let playerName: String = "Roy"
let luckyNumber:Int = 13
let pi:Double = 3.141
var isAuthenticated:Bool = true

var albums: [String] = ["Red", "Fearless"] // Data Type: array of strings
var user: [String: String] = ["id":"@twostraws"] // Data Type: dictionaries
var books: Set<String> = Set([ // Data Type: Sets
    "The Bluest Eye",
    "Foundation",
    "Girl, Woman, Other"
])

var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"] // here the string is not needed b/c the value indicates that it's a string

// These next three do the same
var teams: [String] = [String]() // Here again type annotation is not required
var cities: [String] = [] // this is allowed since we tell it what type the array will be
var clues = [String]() // this is what Paul recommends/uses

enum UIStyle {
    case light, dark, system
}

var style: UIStyle = UIStyle.light // type annotation for enums
style = .dark

let username: String // showing we can declare a constant without giving it a value
// lots of complex logic
username = "@twostraws"
// lots of complex logic
print(username)
