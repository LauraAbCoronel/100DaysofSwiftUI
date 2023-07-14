import Cocoa

/*
 Code for "How to create your own classes"
*/

class Game { // looks like a struct. Can even swap out "class" for "struct"
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

/*
 Code for "How to make on class inherit from another"
*/

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()

/*
 Code for "How to add initializers for classes"
*/

class Vehicle {
    let isElectric: Bool

    init (isElectric:Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

/*
 Code for "How to copy classes"
*/

class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
user2.username = "Taylor" // this will change the username for both user1 and user2

print(user1.username)
print(user2.username)

var user3 = user1.copy()

/*
 Code for "How to create a deinitializer for a class"
*/

class User1 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

var users = [User1]()

for i in 1...3 {
    let user = User1(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user) // if you comment this out you'll see the die once the loop iteration is complete
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

/*
 Code for "How to work with variables inside classes"
*/

class User2 {
    var name = "Paul"
}

var user = User2()
user.name = "Taylor"
user = User2() // this would not be allowed if we set user to a constant with let
print(user.name)

