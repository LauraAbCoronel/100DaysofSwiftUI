//
//  ExplicitAnimations.swift
//  Day32-Animations
//
//  Created by Laura Coronel on 8/2/23.
//

import SwiftUI

struct ExplicitAnimations: View {
	@State private var animationAmount = 0.0
	
    var body: some View {
		Button("Tap Me") {
			withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
				animationAmount += 360
			}
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.rotation3DEffect(
			.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
		)
    }
}

#Preview {
    ExplicitAnimations()
}
