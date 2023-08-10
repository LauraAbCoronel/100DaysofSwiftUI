//
//  LearnNavigationLink.swift
//  Day39
//
//  Created by Laura Coronel on 8/9/23.
//

import SwiftUI

struct LearnNavigationLink: View {
    var body: some View {
		NavigationStack {
			List(0..<100) { row in
				NavigationLink {
					Text("Detail \(row)")
				} label: {
					Text("Row \(row)")
				}
			}
			.navigationTitle("SwiftUI")
		}
    }
}

#Preview {
    LearnNavigationLink()
}
