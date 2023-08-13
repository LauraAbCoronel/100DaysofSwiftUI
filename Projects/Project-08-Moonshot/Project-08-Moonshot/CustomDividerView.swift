//
//  CustomDividerView.swift
//  Project-08-Moonshot
//
//  Created by Laura Coronel on 8/12/23.
//

import SwiftUI

struct CustomDividerView: View {
    var body: some View {
		Rectangle()
			.frame(height: 2)
			.foregroundStyle(.lightBackground)
			.padding(.vertical)
    }
}

#Preview {
    CustomDividerView()
}
