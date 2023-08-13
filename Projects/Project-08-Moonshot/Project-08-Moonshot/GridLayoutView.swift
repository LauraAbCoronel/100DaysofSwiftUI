//
//  GridLayoutView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/12/23.
//

import SwiftUI

struct GridLayoutView: View {
	let astronauts: [String: Astronaut]
	let missions: [Mission]
	
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]

    var body: some View {
		ScrollView {
			LazyVGrid(columns: columns) {
				ForEach(missions) { mission in
					NavigationLink {
						MissionView(mission: mission, astronauts: astronauts)
					} label: {
						VStack {
							Image(mission.image)
								.resizable()
								.scaledToFit()
								.frame(width: 100, height: 100)
								.padding()
							VStack {
								Text(mission.displayName)
									.font(.headline)
									.foregroundStyle(.white)
								Text(mission.formattedLaunchDate)
									.font(.caption)
									.foregroundStyle(.white.opacity(0.5))
							}
							.padding(.vertical)
							.frame(maxWidth: .infinity)
							.background(.lightBackground)
						}
						.clipShape(RoundedRectangle(cornerRadius: 10))
						.overlay(
							RoundedRectangle(cornerRadius: 10)
								.stroke(.lightBackground)
						)
					}
				}
			}
			.padding([.horizontal, .bottom])
		}
    }
}

#Preview {
    GridLayoutView(astronauts: astronauts, missions: missions)
		.preferredColorScheme(.dark)
}
