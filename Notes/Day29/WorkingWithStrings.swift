//
//  WorkingWithStrings.swift
//  Day29
//
//  Created by Laura Coronel on 7/30/23.
//

import SwiftUI

struct WorkingWithStrings: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	
	func separateString() {
		let input = """
a
b
c
"""
		let letters = input.components(separatedBy: "\n")
		let letter = letters.randomElement() ?? "a"
		
		let trimmed = letter.trimmingCharacters(in: .whitespacesAndNewlines)
		print(trimmed)
	}
	
	func spellCheckWord() {
		let word = "swift"
		let checker = UITextChecker()
		
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		
		let allGood = misspelledRange.location == NSNotFound
	}
}

#Preview {
    WorkingWithStrings()
}
