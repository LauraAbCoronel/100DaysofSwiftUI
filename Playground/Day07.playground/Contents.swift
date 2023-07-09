import Cocoa

/*
 Code for "How to reuse code with functions"
*/

func showWelcome() { // syntax for a function
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()

func printTimesTables(number: Int, end: Int) { // this is how we can add a parameter
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20) // number and end are arguments here

/*
 Code for "How to reuse code with functions"
*/

let root = sqrt(169)
print(root)

func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted() // if a function only has one line of code in the body we can remove the return keyword
}

print(areLettersIdentical(string1: "abc", string2: "cba"))

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)

func sayHello() {
    return // even if the function doesn't return anything you can still use return to force the function to stop running
}

/*
 Code for "How to return multiple values from functions"
*/

func getUser() -> (firstName: String, lastName: String) { // returns a tuple
    ("Taylor", "Swift")
}

let (firstName, lastName) = getUser() // you can also use destructuring
print("Name: \(firstName) \(lastName)")


func getUser2() -> (String, String) { // you can also not give names
    ("Taylor", "Swift")
}

let user2 = getUser()
print("Name: \(user2.0) \(user2.1)")

/*
 Code for "How to customize parameter labels"
*/

func rollDice(sides: Int, count: Int) -> [Int] {
    // Start with an empty array
    var rolls = [Int]()

    // Roll as many dice as needed
    for _ in 1...count {
        // Add each result to our array
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }

    // Send back all the rolls
    return rolls
}

let rolls = rollDice(sides: 6, count: 4)

let lyric = "I see a red door and I want it painted black"
print(lyric.hasPrefix("I see"))

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result1 = isUppercase(string)

func printTimesTables(for number: Int) { // you can use for as the external parameter name
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(for: 5)
