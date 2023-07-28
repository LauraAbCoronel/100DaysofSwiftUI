# Day 26: Project 4, part 1
[Link](https://www.hackingwithswift.com/100/swiftui/26)

### BetterRest: Introduction
* Project 4 will be fairly simple project because we are going to be learning about machine learning.
* All iPhones come with a technology called Core ML built right in
  * It allows us to write code that makes predictions about new data based on previous data, then use the results to build an app able to make accurate estimates about new data
* The app we're building is called **BetterRest**. It's designed to help coffee drinkers get a good night's sleep by asking them 3 questions:
  1. When do they want to wake up?
  2. Roughly how many hours of sleep do they want?
  3. How many cups of coffee do they drink per day?
* We'll feed that data into Core ML to get a result telling us when they ought to go to bed
* The ML will use *regression analysis* to come up with an algorithm able to represent all our data.

### Entering numbers with Stepper
* SwiftUI has two ways of letting users enter numbers
  * Stepper: a simple - and + button that can be tapped to select a precise number.
  * Slider, which we’ll be using later on – it also lets us select from a range of values, but less precisely.
* Here's an example of a Stepper: `Stepper("\(sleepAmount) hours", value: $sleepAmount)`
*   When that code runs you’ll see 8.000000 hours, and you can tap the - and + to change the value
* By default steppers are limited only by the range of their storage. 
* Stepper lets us limit the values we want to accept by providing `in` range, like this: `Stepper("\(sleepAmount) hours", value: $sleepAmount, in: 4...12)`
* There's a fourth useful parameter, which is a `step` value – how far to move the value each time - or + is tapped.
* To fix the Stepper so it doesn't show 8.000000, we add a formatting to our sleepAmount state like so: `Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)`


### Selecting dates and times with DatePicker
* SwiftUI gives us a dedicated picker type called DatePicker that can be bound to a date property. 
* Swift has a dedicated type for working with dates, and it’s called – unsurprisingly – `Date`.
* Example of a DatePicker View: `DatePicker("Please enter a date", selection: $wakeUp)`
* If you remove the title of the `DatePickers` we get two problems: 
  * the date picker still makes space for a label even though it’s empty,
  * now users with the screen reader active (more familiar to us as VoiceOver) won’t have any idea what the date picker is for.
* A better alternative is to use the `labelsHidden()` modifier. 
Date pickers provide us with a couple of configuration options that control how they work
* Or you can use the `displayedComponents paramter`
* We can use displayedComponents to decide what kind of options users should see:
  * If you don’t provide this parameter, users see a day, hour, and minute.
  * If you use .date users see month, day, and year.
  * If you use .hourAndMinute users see just the hour and minute components.
  ``` swift
  DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
			.labelsHidden()
  ```
* Finally, there’s an in parameter that works just the same as with Stepper: we can provide it with a date range, and the date picker will ensure the user can’t select beyond it.
* You can also make Swift dates with ranges. For example
``` swift

```
* That’s really useful with DatePicker, but there’s something even better: Swift lets us form one-sided ranges – ranges where we specify either the start or end but not both, leaving Swift to infer the other side.
* For example: `DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)`
* That will allow all dates in the future, but none in the past – read it as “from the current date up to anything.”

### Working with dates
* Having users enter dates is as easy as binding an @State property of type Date to a DatePicker SwiftUI control, but things get a little woolier afterwards.
* Dates are hard. For example if we type cal 9 1752 in the terminal we get the calendar for September 1752 where 12 days are missing
  * This is b/c the calendar moved from Julian to Gregorian
* we should rely on Apple’s frameworks for calculations and formatting.
* In the project we’re making we’ll be using dates in three ways:
  1. Choosing a sensible default “wake up” time.
  2. Reading the hour and minute they want to wake up.
  3. Showing their suggested bedtime neatly formatted.
* Let’s tackle each of those individually, starting with choosing a sensible wake up time.
* DateComponents, which lets us read or write specific parts of a date rather than the whole thing.
* So, if we wanted a date that represented 8am today, we could write code like this:
``` swift
var components = DateComponents()
components.hour = 8
components.minute = 0
let date = Calendar.current.date(from: components)
```
* Now, because of difficulties around date validation, that date(from:) method actually returns an optional date, so it’s a good idea to use nil coalescing to say “if that fails, just give me back the current date”, like this: `let date = Calendar.current.date(from: components) ?? Date.now`
* The second challenge is how we could read the hour they want to wake up. Remember, DatePicker is bound to a Date giving us lots of information, so we need to find a way to pull out just the hour and minute components.
* Again, DateComponents comes to the rescue: we can ask iOS to provide specific components from a date, then read those back out.
* One hiccup is that there’s a disconnect between the values we request and the values we get thanks to the way DateComponents works: we can ask for the hour and minute, but we’ll be handed back a DateComponents instance with optional values for all its properties.
``` swift
let components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
let hour = components.hour ?? 0
let minute = components.minute ?? 0
```
* The last challenge is how we can format dates and times, and here we have two options.
  1. First is to rely on the format parameter that has worked so well for us in the past, and here we can ask for whichever parts of the date we want to show.
* For example, if we just wanted the time from a date we would write this: `Text(Date.now, format: .dateTime.hour().minute())`
* Or if we wanted the day, month, year we could write this: `Text(Date.now, format: .dateTime.day().month().year())`
* You might wonder how that adapts to handling different date formats – for example, here in the UK we use day/month/year, but in some other countries they use month/day/year. 
* we don’t need to worry about this: when we write day().month().year() we’re asking for that data, not arranging it, and iOS will automatically format that data using the user’s preferences.
  2. As an alternative, we can use the formatted() method directly on dates, passing in configuration options for how we want both the date and the time to be formatted, like this: `Text(Date.now.formatted(date: .long, time: .shortened))`
* The point is that dates are hard, but Apple has provided us with stacks of helpers to make them less hard. If you learn to use them well you’ll write less code, and write better code too!

### Training a model with Create ML
* On-device machine learning went from “extremely hard to do” to “quite possible, and surprisingly powerful” in iOS 11, all thanks to one Apple framework: Core ML.
* A year later, Apple introduced a second framework called Create ML, which added “easy to do” to the list.
* a second year later Apple introduced a Create ML app that made the whole process drag and drop.
* Core ML is capable of handling a variety of training tasks, such as recognizing images, sounds, and even motion, but in this instance we’re going to look at tabular regression.
  * we can throw a load of spreadsheet-like data at Create ML and ask it to figure out the relationship between various values.
* Machine learning is done in two steps: 
  1. we train the model - Training is the process of the computer looking at all our data to figure out the relationship between all the values we have, and in large data sets it can take a long time – easily hours, potentially much longer.
  2. Prediction is done on device: we feed it the trained model, and it will use previous results to make estimates about new data.
* We start getting into using Create ML. You can open it up by clicking in the menu Xcode -> Develpoer Tools -> Create ML
* We gave it some sample data
* We selected "actualSleep" as Target. Which means we want the computer to learn how to predict how much sleep they actually need.
* Then we select the other 3 for the Features section. The computer will use those three data points to try to predict actualSleep
* For Algorithms we select the Automatic, where it attempts to choose the best algorithm automatically.
  * Not always the best but good enough. 
* **Tip** Watchen this video to learn about all the different algorithms https://youtu.be/a905KIBw1hs
* Once we train the data we can see how well it was tried by going to the Evaluation tab and selecting Validation. 
  * The value we care about is called Root Mean Squared Error, and you should get a value around about 170.
  * This means on average the model was able to predict suggested accurate sleep time with an error of only 170 seconds, or three minutes.
* **Tip**: Create ML provides us with both Training and Validation statistics, and both are important.
  * When we asked it to train using our data, it automatically split the data up: some to use for training its machine learning model, but then it held back a chunk for validation. 
* If we head over to the Output tab we can see that the size of our model is tiny: 500 bytes