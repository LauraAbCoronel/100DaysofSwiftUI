import Cocoa

/*
 Code for How to store truth with Booleans
*/

//let goodDogs = true
//var gameOver = false
//print(gameOver)
//gameOver.toggle() // Flips Boolean values
//print(gameOver)
//
//var isAuthenticated = false
//isAuthenticated = !isAuthenticated // Flips Boolean values
//print(isAuthenticated)
//isAuthenticated = !isAuthenticated // Flips Boolean values
//print(isAuthenticated)

/*
 Code for How to join strings together
*/

let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart

let people = "Haters"
let action = "hate"
let lyric = people + " gonna " + action
print(lyric)

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old" // this is how we do string interpolation
print(message)

let number = 11
let misionMessage = "Apollo " + String(number) + " landed on the moon." // this is how you can add other Data types to string

print("5 x 5 is \(5 * 5)")
