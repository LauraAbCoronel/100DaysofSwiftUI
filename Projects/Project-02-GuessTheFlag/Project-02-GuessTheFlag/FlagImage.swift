//
//  FlagImage.swift
//  Project-02-GuessTheFlag
//
//  Created by Laura Coronel on 7/25/23.
//

import SwiftUI

struct FlagImage: View {
	let name: String;
	
	var body: some View {
		Image(name)
			.renderingMode(.original)
			.clipShape(Capsule())
			.shadow(radius: 5)
	}
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "US")
    }
}
