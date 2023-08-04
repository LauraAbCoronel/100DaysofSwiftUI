//
//  ViewsWithTransitions.swift
//  Project-06-Animations
//
//  Created by Laura Coronel on 8/3/23.
//

import SwiftUI

struct ViewsWithTransitions: View {
	@State private var isShowingRed = false
	
    var body: some View {
		VStack {
			Button("Tap Me") {
				withAnimation {
					isShowingRed.toggle()
				}
			}
			
			if isShowingRed {
				Rectangle()
					.fill(.red)
					.frame(width: 200, height: 200)
					.transition(.asymmetric(insertion: .scale, removal: .opacity))
			}
		}
    }
}

#Preview {
    ViewsWithTransitions()
}
