//
//  MissionView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/11/23.
//

import SwiftUI

struct MissionView: View {
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	}
	
	let mission: Mission
	let crew: [CrewMember]
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack {
					Image(mission.image)
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width * 0.6)
						.padding(.vertical)
					
					if let date = mission.launchDate {
						Label(date.formatted(date: .complete, time: .omitted), systemImage: "calendar")
					}
										
					VStack(alignment: .leading) {
						CustomDividerView()
						
						Text("Mission Highlights")
							.font(.title.bold())
							.padding(.bottom, 5)
						
						Text(mission.description)
						
						CustomDividerView()
						
						Text("Crew")
							.font(.title.bold())
							.padding(.bottom, 5)
					}
					.padding(.horizontal)
					
					AstronautListView(crew: crew)
				}
				.padding(.bottom)
			}
		}
		.navigationTitle(mission.displayName)
		.navigationBarTitleDisplayMode(.inline)
		.background(.darkBackground)
	}
	
	init(mission: Mission, astronauts: [String: Astronaut]) {
		self.mission = mission
		
		self.crew = mission.crew.map { member in
			if let astronaut = astronauts[member.name] {
				return CrewMember(role: member.role, astronaut: astronaut)
			} else {
				fatalError("Missing \(member.name)")
			}
		}
	}
}

let missions: [Mission] = Bundle.main.decode("missions.json")
let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

#Preview {
	MissionView(mission: missions[1], astronauts: astronauts)
		.preferredColorScheme(.dark)
}
