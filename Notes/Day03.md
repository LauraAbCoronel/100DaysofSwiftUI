# Day 3
[Link](https://www.hackingwithswift.com/100/swiftui/3)

### How to store ordered data in arrays
* Start counting array at 0
* To get access to an array you use brackets
  * `arrayName[0]`
* Use `.append` to add to the end of an array
* An array can only have one data type
* To create a blank array you use
  * `Array<DataType>()` Or `[DataType]()`
  * The parenthesis is there because there is a way to customize how you create an array
* To get the length of an array you can use `.count`
* To remove a character you use 
  * `arrayName.remove(at: Int)`
* And you can remove all with `.removeAll()`
* `.contains(ITEM)` 
  * let’s you check if the array contains an item. It needs to match exactly
* `.reversed()` reverses an array BUT
  * it doesn’t reverse it right away. It optimized by storing that it knows it’s reverse so if you ask for an item it will reverse then give it to you
  * It gives you a reversed collection
  * To get the value you need to revert it back to an array or use collection methods like `.first`

### How to store and find data in dictionaries
* To create a diction is the same as creating an array except you add key’s and names
  * `[“name”: “Taylor Swift]`
* To read a value you do the same for arrays except you just enter the key in the brackets
  * `employee[“name”]`
* When you try to read any value in a dictionary Xcode gives you a warning
  * The warning tells us we might get a value back or we might get nothing at all
  * To get rid of this warning we can give it a default value if it cannot find it.
    * `employee["name", default: "Unknown”]`
* Keys and values can be any data type
* You can create a blank dictionary similar to how you would for an array except you need to tell it the data type for both key and value
  * `[String: Int]()`
* `.count` and `.removeAll()` works on dictionaries too

### How to use sets for fast data lookup
* Using Set will automatically remove any duplicate value from the array and not remember the order
* Printing the set can be in complete different order than the viewer
* Since they are not in order, you cannot use `.append()` to add an item. INSTEAD you use `.insert()`
* Instead of storing your items in the exact order you specify, sets instead store them in a highly optimized order that makes it very fast to locate items.
* Designed specifically for fast look up designers
* Alongside `contains()`, you’ll also find count to read the number of items in a set, and `sorted()` to return a sorted array containing the the set’s items.

### How to create and use enums
* Enums are a data type where we can dictate what values it can be 
  * For example the days of the week
* You can write case for each case or separate them by commas
* The way you use a enum is enumName.Case
  * Example `Weekday.monday`
* When you declare a variable it remembers it’s data type so next time you set the variable you don’t need to write the enums name again
  * Example `day = .tuesday`
* Cases cannot be a number
* Behind the scenes, Swift can store its enum values very simply, so they are much faster to create and store than something like a string.
