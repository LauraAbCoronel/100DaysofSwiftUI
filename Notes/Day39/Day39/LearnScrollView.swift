//
//  LearnScrollView.swift
//  Day39
//
//  Created by Laura Coronel on 8/9/23.
//

import SwiftUI

struct CustomText: View {
	let text: String

	var body: some View {
		Text(text)
	}

	init(_ text: String) {
//		print("Creating a new CustomText")
		self.text = text
	}
}

struct LearnScrollView: View {
    var body: some View {
		ScrollView(.horizontal) {
			LazyHStack(spacing: 10) {
				ForEach(0..<100) {
					CustomText("Item \($0)")
						.font(.title)
				}
			}
		}
    }
}

#Preview {
    LearnScrollView()
}
