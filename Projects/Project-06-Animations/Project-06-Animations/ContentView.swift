//
//  ContentView.swift
//  Project-06-Animations
//
//  Created by Laura Coronel on 8/3/23.
//

import SwiftUI

struct ContentView: View {
	@State private var enable = false
	
    var body: some View {
		Button("Tap Me") {
			enable.toggle()
		}
		.frame(width: 200, height: 200)
		.background(enable ? .blue : .red)
		.animation(nil, value: enable)
		.foregroundStyle(.white)
		.clipShape(RoundedRectangle(cornerRadius: enable ? 60 : 0))
		.animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enable)
		
    }
}

#Preview {
    ContentView()
}
