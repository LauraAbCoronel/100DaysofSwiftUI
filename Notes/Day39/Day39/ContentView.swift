//
//  ContentView.swift
//  Day39
//
//  Created by Laura Coronel on 8/9/23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		GeometryReader { geo in
			Image("rocket")
				.resizable()
				.scaledToFit()
				.frame(width: geo.size.width * 0.8)
				.frame(width: geo.size.width, height: geo.size.width)
		}
	}
}

#Preview {
	ContentView()
}
