import Cocoa

/*
 Code from "How to limit access to internal data using access control"
*/

struct BankAccount {
    private(set) var funds = 0 // doesn't let people directly change this value

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// How we plan for it to work
var account = BankAccount()
let success = account.withdraw(amount: 200)
if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}
// We dont want this to happen account.funds -= 1000

/*
 Code from "Static properties and methods"
*/

struct School {
    static var studentCount = 0
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}
School.add(student: "Taylor Swift")
print(School.studentCount)

// one reason to use stactic is to organize common data in apps
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://hackingwithswift.com"
}

AppData.version

struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "cfederighi", password: "h4irf0rce0ne") // only available for the struct.
}

Employee.example
