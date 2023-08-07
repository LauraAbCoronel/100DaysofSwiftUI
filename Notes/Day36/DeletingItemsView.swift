//
//  DeletingItemsView.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

struct DeletingItemsView: View {
	@State private var numbers = [Int]()
	@State private var currentNumber = 1
	
	var body: some View {
		NavigationStack {
			VStack {
				List {
					ForEach(numbers, id: \.self) {
						Text("Row \($0)")
					}
					.onDelete(perform: removeRows)
				}
				
				Button("Add Number") {
					numbers.append(currentNumber)
					currentNumber += 1
				}
			}
			.navigationTitle("onDelete()")
			.toolbar {
				EditButton()
			}
		}
	}
	
	func removeRows(at offsets: IndexSet) {
		numbers.remove(atOffsets: offsets)
	}
}

#Preview {
	DeletingItemsView()
}
