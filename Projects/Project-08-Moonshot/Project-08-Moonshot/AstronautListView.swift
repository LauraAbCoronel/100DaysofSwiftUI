//
//  AstronautListView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/12/23.
//

import SwiftUI

struct AstronautListView: View {
	let crew: [MissionView.CrewMember]

	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(crew, id: \.role) { crewMember in
					NavigationLink {
						AstronautView(astronaut: crewMember.astronaut)
					} label: {
						HStack {
							Image(crewMember.astronaut.id)
								.resizable()
								.frame(width: 104, height: 72)
								.clipShape(Capsule())
								.overlay(
									Capsule()
										.strokeBorder(.white, lineWidth: 1)
								)
							
							VStack(alignment: .leading) {
								Text(crewMember.astronaut.name)
									.foregroundStyle(.white)
									.font(.headline)

								Text(crewMember.role)
									.foregroundStyle(.secondary)
							}
						}
						.padding(.horizontal)
					}
				}
			}
		}
    }
}

//#Preview {
//	AstronautListView(crew: missions[0].crew)
//}
