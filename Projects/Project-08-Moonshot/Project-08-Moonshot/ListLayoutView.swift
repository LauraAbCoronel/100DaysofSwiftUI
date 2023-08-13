//
//  ListLayoutView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/12/23.
//

import SwiftUI

struct ListLayoutView: View {
	let astronauts: [String: Astronaut]
	let missions: [Mission]
	
    var body: some View {
		List(missions) { mission in
			NavigationLink {
				MissionView(mission: mission, astronauts: astronauts)
			} label: {
				HStack {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(width: 40, height: 40)
						.padding()
					
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
						
						Text(mission.formattedLaunchDate)
					}
				}
			}
			.listRowBackground(Color.darkBackground)
		}
		.listStyle(.plain)
    }
}

#Preview {
    ListLayoutView(astronauts: astronauts, missions: missions)
		.preferredColorScheme(.dark)
}
