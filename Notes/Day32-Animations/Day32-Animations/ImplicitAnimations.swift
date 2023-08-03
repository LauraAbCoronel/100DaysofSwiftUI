//
//  ContentView.swift
//  Day32-Animations
//
//  Created by Laura Coronel on 8/2/23.
//

import SwiftUI

struct ImplicitAnimations: View {
	@State private var animationAmount = 1.0
	
    var body: some View {
		Button("Tap Me") {
			animationAmount += 1
		}
		.padding(50)
		.background(.red)
		.foregroundStyle(.white)
		.clipShape(Circle())
		.scaleEffect(animationAmount)
		.blur(radius: (animationAmount - 1) * 3)
		.animation(.default, value: animationAmount)
    }
}

#Preview {
    ImplicitAnimations()
}
