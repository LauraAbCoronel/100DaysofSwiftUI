//
//  StoringUserSettings.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

struct StoringUserSettings: View {
	@AppStorage("tapCount") private var tapCount = 0
	
	var body: some View {
		Button("Tap count: \(tapCount)") {
			tapCount += 1
		}
    }
}

#Preview {
    StoringUserSettings()
}
