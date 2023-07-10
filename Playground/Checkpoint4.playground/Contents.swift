import Cocoa

/*
 Write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number
    - You can't use the built-in sqrt() function or similar - you need to find the square root yourself
    - If the number is less than 1 or greater than 10,000 you should throw an "out of bounds" error
    - You should only consider integer square roots
    - If you can't find the square root, throw a "no root" error.
*/

enum squareRootError: Error {
    case outOfBounds, noRoot
}

func squareRoot(of number: Int) throws -> Int {
    switch number {
    case 0...10_000:
        for i in 1...100 { // only go to 100 b/c sqrt of 10,000 is 100
            if i * i == number {
                return i
            } else if i * i > number { // if we pass the number then there's no root
                throw squareRootError.noRoot
            }
        }
        throw squareRootError.noRoot
    default:
        throw squareRootError.outOfBounds
    }
}


do {
    let root = try squareRoot(of: 2500)
    print(root)
} catch squareRootError.outOfBounds {
    print("Your number was out of bounds")
} catch squareRootError.noRoot {
    print("No root was found")
} catch {
    print("An error occured: \(error.localizedDescription)")
}
