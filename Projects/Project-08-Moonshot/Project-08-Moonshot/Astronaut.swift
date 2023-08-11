//
//  Astronaut.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/10/23.
//

import Foundation

// Codable: so that we can create instances of this struct straight from JSON
// Identifiable: use arrays of astronauts inside ForEach
struct Astronaut: Codable, Identifiable {
	let id: String
	let name: String
	let description: String
}
