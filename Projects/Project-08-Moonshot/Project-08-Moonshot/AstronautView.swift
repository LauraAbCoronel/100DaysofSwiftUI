//
//  AstronautView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/11/23.
//

import SwiftUI

struct AstronautView: View {
	let astronaut: Astronaut
	
    var body: some View {
		ScrollView {
			VStack {
				Image(astronaut.id)
					.resizable()
					.scaledToFit()
				
				Text(astronaut.description)
					.padding()
			}
		}
		.background(.darkBackground)
		.navigationTitle(astronaut.name)
		.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
	AstronautView(astronaut: astronauts["armstrong"]!)
		.preferredColorScheme(.dark)
}
