//
//  ContentView.swift
//  Project-01-WeSplit
//
//  Created by Laura Coronel on 7/17/23.
//

import SwiftUI

struct ContentView: View { // creates a new struct called ContentView
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        // calculate the total per person
        grandTotal / Double(numberOfPeople + 2)
    }
    
    var localeCurrency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View { // new computed property called body & required by View
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localeCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(grandTotal, format: localeCurrency)
						.foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: localeCurrency)
                } header: { // challenge 1
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
