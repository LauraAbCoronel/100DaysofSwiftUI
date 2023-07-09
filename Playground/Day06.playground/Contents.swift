import Cocoa

/*
 Code for "How to use a for loop to repeat work"
*/

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
print(platforms[1...])

for os in platforms {
    print("Swift works great on \(os).")
}

for i in 1...12 {
    print("The \(i) times table")
    for j in 1...12 {
        print("      \(j) x \(i) is \(j * i)")
    }

    print()
}

for i in 1...5 {
    print("Counting from 1 through 5: \(i)") // includes 5
}

for i in 1..<5 {
    print("Counting from 1 up to not including 5: \(i)") // does not include 5
}

var lyric = "Haters gonna"
for _ in 1...5 { // if you don't need a loop variable
    lyric += " hate"
}
print (lyric)

/*
 Code for "How to use a while loop to repeat work"
*/

var countdown = 10
while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}
print("Blast off!")

let id = Int.random(in: 1...1000) // get a random number from 1 to 1000
let amount = Double.random(in: 0...1)

var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
print("Critical hit!")

/*
 Code for "How to skip loop items with break and continue"
*/

let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        
        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)
