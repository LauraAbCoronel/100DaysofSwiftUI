//
//  ContentView.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

class User: ObservableObject {
	@Published var firstName = "Bilbo"
	@Published var lastName = "Baggins"
}

struct ContentView: View {
	@StateObject var user = User()
	
    var body: some View {
        VStack {
			Text("Your name is \(user.firstName) \(user.lastName)")
			
			TextField("First name", text: $user.firstName)
			TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
