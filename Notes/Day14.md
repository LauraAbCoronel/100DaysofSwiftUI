# Day 14: Optionals
[Link](https://www.hackingwithswift.com/100/swiftui/14)

### How to handle missing data with optionals
* Swift has another important way of ensuring predictability called `optionals`
  * a word meaning “this thing might have a value or might not.”
* Swift has a value called nil which means "no value"
* Swift gives us two primary ways of unwrapping optionals, but the one you’ll see the most looks like this:
``` swift
if let marioOpposite = opposites["Mario"] {
  print("Mario's opposite is \(marioOpposite)") // marioOpposite only available in here
}
```
* To have a variable that can either store a string or nil will look like this:
``` swift
var username: String? = nil
```
* A common way to unwrap an optional variable is like so
``` swift
var number:Int? = nil
if let number = number {
    print(square(number: number))
}
```
* Here we are temporarily creating a second constant of the same name, available only inside the condition's body.
  * This is called shadowing
* Another perspective on optionals: [Link](https://www.youtube.com/watch?v=7a7As0uNWOQ)

### How to unwrap optionals with guard
* There's another way to unwrap optionals called `guard let`
* Here's an example of how it looks
``` swift
func printSquare(of number: Int?) {
  guard let number = number else {
    print("missing input") // this runs if number is nil
    return // this is required
  }
  print("\(number) x \(number) is \(number * number)")
}
```
* guard checks if the value exist and if it does it saves it in a temporary variable
* Swift requires you to use `return` if a `guard` check fails
* If the optional you're unwrapping has a value, you can use it *after* the `guard` code finishes
* You can use guard with any condition, including ones that don’t unwrap optionals. For example, you might use `guard someArray.isEmpty else { return }`.

### How to unwrap optionals with nil coalescing
* There's a third way to wrap optionals called nil coalescing operator 
* It would look something like this:
``` swift
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]
let new = captains["Serenity"] ?? "N/A" // replace nil with "N/A"
```
* This is not only useful for dictionaries but you can use it for any optional like so:
``` swift
let input = ""
let number = Int(input) ?? 0 // replace nil with 0
print(number)
```
* You can chain nil coalescing if you want to, although I don't think it's common. 
  * `let saved Data = first() ?? second() ?? ""`
  * This will attempt to run `first()`, and if that returns nil attempt to run `second()`, and if *that* returns nil then it will use an empty string
* Remember, reading a dictionary key will always return an optional, so you might want to use nil coalescing here to ensure you get back a non-optional
  * but remember that dictionaries also let you set a default value

### How to handle multiple optionals using optional chaining
* Optional chaining is a simplified syntax for reading optionals inside optionals.
* Here's an example:
``` swift
let names = ["Arya", "Bran", "Robb", "Sansa"]
let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")
```
* Optional chaining allows us to say “if the optional has a value inside, unwrap it then…”
  * In our case then `uppercased()` it
* Optional chain can go as long as it wants
* Optional reading on [optional chaining](https://andybargh.com/optional-chaining/)

### How to handle function failure with optionals
* If all we care about is whether the function succeeded or failed, we can use an optional try to have the function return an optional value. 
*  If the function ran without throwing any errors then the optional will contain the return value, but if any error was thrown the function will return nil.
  * This means we won't know what error was thrown
* Here's how it looks:
``` swift
enum UserError: Error {
  case badID, networkFailed
}
func getUser(id: Int) throws -> String {
  throw UserError.networkFailed
}
if let user = try? getUser(id: 23) { // instead of doing try and catch you can just write try?
  print("User: \(user)")
}
```
* In the above example we'll just get nil since the function throws an error
* You can combine it with nil coalescent like so: `let user = (try? getUser(id: 23)) ?? "Anonymous"`
* You'll mainly find `try?` used in three places:
  1. In combination with `guard let` to exit the current function if the `try?` call returns `nil`
  2. In combination with nil coalescing to attempt something or provide a default value on failure.
  3. When calling any throwing function without a return value, when you genuinely don't care if it succeeded or not - maybe you're writing to a log file or sending analytics to a server, for example.

### Summary: Optionals
* Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
* As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.
* Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be `nil` inside.
* We can use `if let` to run some code if the optional has a value, or `guard let` to run some code if the optional doesn’t have a value – but with `guard` we must always exit the function afterwards.
* The nil coalescing operator, `??`, unwraps and returns an optional’s value, or uses a default value instead.
* Optional chaining lets us read an optional inside another optional with a convenient syntax.
* If a function might throw errors, you can convert it into an optional using `try?` – you’ll either get back the function’s return value, or `nil` if an error is thrown.