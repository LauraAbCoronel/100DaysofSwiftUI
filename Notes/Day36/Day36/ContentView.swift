//
//  ContentView.swift
//  Day36
//
//  Created by Laura Coronel on 8/6/23.
//

import SwiftUI

class User {
	var firstName = "Bilbo"
	var lastname = "Baggins"
}

struct ContentView: View {
	@State private var user = User()
	
    var body: some View {
        VStack {
			Text("Your name is \(user.firstName) \(user.lastname)")
			
			TextField("First name", text: $user.firstName)
			TextField("Last name", text: $user.lastname)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
