# Day 38: Project 7, part 3
[Link](https://www.hackingwithswift.com/100/swiftui/38)

### Challenge
1. Use the user's preferred currency, rather than always using US dollars
* I created a variable to store the user's preferred currency. Then passed this variable to the Text format.
* I also saved it outside content view so I can use it in both views
```swift
	var localCurrency: FloatingPointFormatStyle<Double>.Currency {
		.currency(code: Locale.current.currency?.identifier ?? "USD")
	}
```
* What Paul does instead he creates a new File and add an extension to the `FormatStyle`. Then when we call it we can use `.localCurrency`
```swift
extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
	static var localCurrency: Self {
		.currency(code: Locale.current.currency?.identifier ?? "USD")
	}
}
```

2. Modify the expense amounts in `ContentView` to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
* I just added a style that changed the color. So if you're spending less the color is green, then yellow and if you spend too much then it's red
```swift
Text(item.amount, format: localCurrency)
  .foregroundStyle(
    item.amount < 10 ? .green :
      item.amount < 100 ? .yellow :
        .red
  )
```
* What Paul does is create a new file so he can store the changes as an extension to View.
```swift 
extension View {
	func style(for item: ExpenseItem) -> some View {
		if item.amount < 10 {
			return self.font(.body)
		} else if item.amount < 100 {
			return self.font(.title3)
		} else {
			return self.font(.title)
		}
	}
}
```

3. For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
* Probably not the best way to handle it but I wrapped the `ForEach` view with a section view and added an if statement that checks if the type is personal. Then I copied all the code and did the same for "Business"
```swift
Section("Personal") {
  ForEach(expenses.items) { item in
    if item.type == "Personal" {
      HStack {
        VStack(alignment: .leading) {
          Text(item.name)
            .font(.headline)
          Text(item.type)
        }
        Spacer()
        Text(item.amount, format: localCurrency)
          .foregroundStyle(
            item.amount < 10 ? .green :
              item.amount < 100 ? .yellow :
                .red
          )
      }
    }
  }
  .onDelete(perform: { indexSet in
    removeItems(at: indexSet)
  })
}
```
* Paul did ALOT of changes and different things you just gotta see the video to understand 
  * https://www.hackingwithswift.com/plus/solutions/iexpense