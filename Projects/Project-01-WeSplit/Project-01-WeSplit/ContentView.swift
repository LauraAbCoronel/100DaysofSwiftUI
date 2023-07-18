//
//  ContentView.swift
//  Project-01-WeSplit
//
//  Created by Laura Coronel on 7/17/23.
//

import SwiftUI

struct ContentView: View { // creates a new struct called ContentView
    @State private var tapCount = 0
    
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View { // new computed property called body & required by View
        NavigationView {
            Form {
                Section { // from Navigation video
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                Section { // from Modifying program state video
                    Button("TapCount: \(tapCount)") {
                        tapCount += 1
                    }
                }
                Section { // from binding state
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }
                Section { // from creating views in a loop
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
