//
//  Bundle-Decodable.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/10/23.
//

import Foundation

extension Bundle {
	func decode<T: Codable>(_ file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}
		
		let decoder = JSONDecoder()
		let formatter = DateFormatter()
		formatter.dateFormat = "y-MM-dd" // when you find dates they will be in this format
		// you would generatly want to display your timezone
		decoder.dateDecodingStrategy = .formatted(formatter)
		
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		return loaded
	}
}
