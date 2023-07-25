//
//  ContentView.swift
//  Project-03-ViewsAndModifiers
//
//  Created by Laura Coronel on 7/24/23.
//

import SwiftUI

struct Watermark: ViewModifier {
	var text: String
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			
			Text(text)
				.font(.caption)
				.foregroundColor(.white)
				.padding(5)
				.background(.black)
		}
	}
}

struct Title: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.foregroundColor(.white)
			.padding()
			.background(.blue)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

extension View {
	func watermarked(with text: String) -> some View {
		modifier(Watermark(text: text))
	}
	
	func titleStyle() -> some View {
		modifier(Title())
	}
}

struct ContentView: View {
    var body: some View {
		Color.blue
			.frame(width: 300, height: 200)
			.watermarked(with: "Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
