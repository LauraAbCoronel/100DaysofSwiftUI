import Cocoa

/*
 Write a Swift program to compute the sum of the two integers. If the values are equal return the triple their sum.
*/

func triple_sum(a num1: Int, b num2: Int) -> Int {
    if num1 == num2 {
        return (num1 + num2) * 3
    } else {
        return num1 + num2
    }
}
print(triple_sum(a: 1, b: 2))

