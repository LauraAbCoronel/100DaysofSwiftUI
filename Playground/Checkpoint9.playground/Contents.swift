import Cocoa

/*
 - Write a function that accepts an optional array of integers, and returns one of those integers randomly
 - If the array is missing or empty, return a new random number in the range 1 through 100
 - Write your function in a single line of code.
*/

func randomIntElement(in arr: [Int]?) -> Int {
    arr?.randomElement() ?? Int.random(in: 1...100)
}

print(randomIntElement(in: [1,2,3,4]))
print(randomIntElement(in: nil))
