# Day 18: Project 1, part three
[Link](https://www.hackingwithswift.com/100/swiftui/18)

### WeSplit: Wrap up
* We have a challenge to try on our own
1. Add a header to the third section, saying "Amount per person"
  * I just added a `header` to the end of the `Section` view
2. Add another section showing the total amount for the check - i.e., the original amount plus tip value, without dividing by the number of people
  - I created a new calculated variable by moving the grandtotal calculation out on it's own. 
  - Then I added a new section at the bottom displaying the new variable and added a header so we know what it is.
3. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options - everything from 0% to 100%. Tip: use the range 0..101 for your range rather than a fixed array.
  - I removed the segmented styling to the picker. I also change the ForEach view to go from 1 to 100 instead of in an array.
* From doing challenge 3 I learned that ForEach view must use `..<` NOT `...`. I wonder why
We then get another challenge to make a new property to store the currency formatter. I did so like this
``` swift
var localeCurrency: FloatingPointFormatStyle<Double>.Currency {
  .currency(code: Locale.current.currency?.identifier ?? "USD")
}
```