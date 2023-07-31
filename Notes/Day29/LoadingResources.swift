//
//  LoadingResources.swift
//  Day29
//
//  Created by Laura Coronel on 7/30/23.
//

import SwiftUI

struct LoadingResources: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	
	func loadFile() {
		if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
			// we found the file in our bundle!
			if let fileContents = try? String(contentsOf: fileURL) {
				// we loaded the file into the string
			}
		}
	}
}

#Preview {
    LoadingResources()
}
