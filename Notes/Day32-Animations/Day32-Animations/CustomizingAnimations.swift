//
//  CustomizingAnimations.swift
//  Day32-Animations
//
//  Created by Laura Coronel on 8/2/23.
//

import SwiftUI

struct CustomizingAnimations: View {
	@State private var animationAmount = 1.0
	
	var body: some View {
		Button("Tap Me") {
//			animationAmount += 1
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.overlay(
			Circle()
				.stroke(.red)
				.scaleEffect(animationAmount)
				.opacity(2 - animationAmount)
				.animation(
					.easeInOut(duration: 2)
						.repeatForever(autoreverses: false),
					value: animationAmount
				)
		)
		.onAppear {
			animationAmount = 2
		}
	}
}

#Preview {
    CustomizingAnimations()
}
