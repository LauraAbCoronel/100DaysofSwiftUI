//
//  ContentView.swift
//  Day29
//
//  Created by Laura Coronel on 7/30/23.
//

import SwiftUI

struct ListIntro: View {
	let people = ["Finn", "Leia", "Luke", "Rey"]
	
	var body: some View {
		List {
			Text("Static row")
			
			ForEach(people, id: \.self) {
				Text("\($0)")
			}

			Text("Static row")
		}
		.listStyle(.grouped)
	}
}

#Preview {
	ListIntro()
}
