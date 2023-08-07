//
//  ShowAndHideViews.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

struct SecondView: View {
	@Environment(\.dismiss) var dismiss
	let name: String
	var body: some View {
		Button("Dismiss") {
			dismiss()
		}
	}
}

struct ShowAndHideViews: View {
	@State private var showingSheet = false
	
    var body: some View {
		Button("Show Sheet") {
			showingSheet.toggle()
		}
		.sheet(isPresented: $showingSheet) {
			SecondView(name: "Laura")
		}
    }
}

#Preview {
    ShowAndHideViews()
}
