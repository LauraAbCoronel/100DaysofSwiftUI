import Cocoa

/*
 - Create a struct to store information about a car, including:
    - Its model
    - Number of seats
    - Current gear
 - Add method to change gears up or down
 - Have a think about variables and access control
 - Don't allow invalid gears - 1...10 seems a fair maximum range
*/

struct Car {
    let model: String
    let seats: Int
    let maxGears: Int
    private(set) var gear = 1
    
    mutating func changeGear(difference: Int) {
        let newGear = gear + difference
        
        if newGear >= 1 && newGear <= maxGears {
            gear = newGear
        } else if newGear < 1 {
            gear = 1
            print("Gear can't go lower than 1 Current gear: \(gear)")
        } else {
            gear = maxGears
            print("Gear can't go higher than \(maxGears). Current gear: \(gear)")
        }
    }
//    mutating func gearUp() {
//        if gear != 10 {
//            gear += 1
//        } else {
//            print("Gear can't go any higher. Current gear: \(gear)")
//        }
//    }
//    mutating func gearDown() {
//        if gear != 1 {
//            gear -= 1
//        } else {
//            print("Gear can't go any lower. Current gear: \(gear)")
//        }
//    }
    init(model: String, seats: Int, maxGears: Int) {
        self.model = model
        self.seats = seats
        self.maxGears = maxGears
    }
}

// I wish he gave us tests to make sure we did it right
var vw = Car(model: "SportWagen", seats: 5, maxGears: 7)
vw.changeGear(difference: 5)
vw.changeGear(difference: -10)
print(vw.gear)
vw.changeGear(difference: 10)
