import Cocoa

/*
 - Make a protocol that describes a building
 - Your protocol should require the following:
    - A property storing how many rooms it has.
    - A property storing the cost as an integer
    - A property storing the name of the estate agent selling the building
    - A method for printing the sales summary of the building
 - Create two structs, House and Office, that conform to it.
*/

protocol Building {
    var type: String { get }
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    func printSummary()
}

extension Building {
    func printSummary() {
        print("Talk to \(agent) to buy this \(type) for $\(cost)")
    }
}

struct House: Building {
    let type = "house"
    let rooms: Int
    var cost: Int
    var agent: String
}

struct Office: Building {
    let type = "office"
    let rooms: Int
    var cost: Int
    var agent: String
}
