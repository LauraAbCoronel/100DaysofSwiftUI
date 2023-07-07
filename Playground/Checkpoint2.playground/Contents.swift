import Cocoa

/*
 Create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.
*/

// Solution 1
let arrStrings = ["one", "two", "three", "four", "three", "two", "one"]
print(arrStrings.count)

let setString = Set(arrStrings)
print(setString.count)

// Solution 2
let arrStrings2 = ["one", "two", "three", "four", "three", "two", "one"]
print("The array has \(arrStrings2.count) items and \(Set(arrStrings2).count) are unique")
