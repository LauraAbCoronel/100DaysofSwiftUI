//
//  AnimationBindings.swift
//  Day32-Animations
//
//  Created by Laura Coronel on 8/2/23.
//

import SwiftUI

struct AnimationBindings: View {
	@State private var animationAmount = 1.0
	
    var body: some View {
		print(animationAmount)
		
		return VStack {
			Stepper(
				"Scale amount",
				value: $animationAmount
					.animation(
						.easeInOut(duration: 1)
						.repeatCount(3, autoreverses: true)
					),
				in: 1...10
			)
			
			Spacer()
			
			Button("Tap Me") {
				animationAmount += 1
			}
			.padding(40)
			.background(.red)
			.foregroundStyle(.white)
			.clipShape(Circle())
			.scaleEffect(animationAmount)
		}
    }
}

#Preview {
    AnimationBindings()
}
