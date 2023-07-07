import Cocoa

/*
 - Create a constant holding any temperature in Celsius
 - Convert that temperature to Fahrenheit by multiplying by 9, dividing by 5, then adding 32
 - Prints the results showing both the Celsius and Fahrenheit values.
*/


let celsius = 26.6
let fahrenheit = celsius * 9/5 + 32

print("\(celsius)°C is \(fahrenheit)°F")

let fahrenheit1 = 80.0
let celsius1 = (fahrenheit1 - 32) * 5/9

print("\(fahrenheit1)°F is \(celsius1)°C")
