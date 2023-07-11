import Cocoa

/*
 Code for "How to create and use closures"
*/

func greetUser() {
    print("hi there!")
}

greetUser()
var greetCopy: () -> Void = greetUser // copies the function
greetCopy()

let sayHello = { // you can set a function to a variable
    print("Hi there!")
}
sayHello()

let sayHello1 = { (name: String) -> String in
    "Hi \(name)!"
}
sayHello1("Taylor")

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
}

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam)

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
})
print(captainFirstTeam)

/*
 Code for "How to use trailing closures and shorthand syntax"
*/

let team1 = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let captainFirstTeam1 = team.sorted { name1, name2 in // b/c sorted forces you to pass 2 parameters that are strings and return a bool we can simplify it to this
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

print(captainFirstTeam)

let captainFirstTeam2 = team.sorted { // we can simplify it even further by removing the parameter names and using the names Swift provides
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

let tOnly = team.filter { $0.hasPrefix("T")}
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

/*
 Code for "How to accept functions as parameters"
*/

func greetUser1() {
    print("Hi there!")
}

greetUser()

var greetCopy1: () -> Void = greetUser
greetCopy()

func makeArray(size: Int, using generator: () -> Int) -> [Int] { // generator is a function type
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

// OR

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}
