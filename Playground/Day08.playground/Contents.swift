import Cocoa

/*
 Code for "How to provide default values for paramters"
*/

func printTimesTables(for number: Int, end: Int = 12) { // we gave the end parameter a default value
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll()
print(characters)

/*
 Code for "How to handle errors in functions"
*/

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String { // if a function can throw an error you must mark it by adding throws before the return data type
    if password.count < 5 {
        throw PasswordError.short // you then call throw for the specific condition
        
    }
    if password == "12345" {
        throw PasswordError.obvious
        
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string) // try must be written before all throwing functions
} catch PasswordError.short {
    print("Please use a longer password")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error: \(error.localizedDescription)") // if we want to use/print Apples error we use error.localizedDescription
}
