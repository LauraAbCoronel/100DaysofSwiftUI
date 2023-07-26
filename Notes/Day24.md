# Day 24: Project 3, part 2
[Link](https://www.hackingwithswift.com/100/swiftui/24)

### Challenge
1. Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.
``` swift
Text(grandTotal, format: localeCurrency)
  .foregroundColor(tipPercentage == 0 ? .red : .primary)
```

2. Go back to project 2 and replace the `Image` view used for flags with a new `FlagImage()` view that renders one flag image using the specific set of modifiers we had.
``` swift
struct FlagImage: View {
	let name: String;
	
	var body: some View {
		Image(name)
			.renderingMode(.original)
			.clipShape(Capsule())
			.shadow(radius: 5)
	}
}

struct ContentView: View {
  ...
  ForEach(0..<3) { number in
    Button {
      flagTapped(number)
    } label: {
      FlagImage(name: countries[number])
    }
}
```

3. Create a custom `ViewModifier` (and accompanying `View` extension) that makes a view have a large, blue font suitable for prominent titles in a view.
``` swift
	func body(content: Content) -> some View {
		content
			.font(.largeTitle.bold())
			.foregroundColor(.blue)
	}
}

extension View {
	func prominentTitle() -> some View {
		modifier(BlueTitle())
	}
}
```