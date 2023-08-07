//
//  ArchivingSwiftObjects.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

struct User: Codable {
	let firstName: String
	let lastName: String
}

struct ArchivingSwiftObjects: View {
	@State private var user = User(firstName: "Taylor", lastName: "Swift")
	
    var body: some View {
		Button("Save User") {
			let encoder = JSONEncoder()
			
			if let data = try? encoder.encode(user) {
				UserDefaults.standard.setValue(data, forKey: "User")
			}
		}
    }
}

#Preview {
    ArchivingSwiftObjects()
}
