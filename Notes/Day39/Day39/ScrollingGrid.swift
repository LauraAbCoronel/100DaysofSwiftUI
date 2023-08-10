//
//  ScrollingGrid.swift
//  Day39
//
//  Created by Laura Coronel on 8/9/23.
//

import SwiftUI

struct ScrollingGrid: View {
	let layout = [
		GridItem(.adaptive(minimum: 80, maximum: 120))
	]
	
    var body: some View {
		ScrollView {
			LazyVGrid(columns: layout) {
				ForEach(0..<1000) {
					Text("Item \($0)")
				}
			}
		}
    }
}

#Preview {
    ScrollingGrid()
}
