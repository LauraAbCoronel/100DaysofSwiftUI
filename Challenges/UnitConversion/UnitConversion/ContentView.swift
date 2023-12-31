//
//  ContentView.swift
//  UnitConversion
//
//  Created by Laura Coronel on 7/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 32.0
    @State private var selectedUnits = 2
    @State private var inputUnit:Dimension = UnitTemperature.fahrenheit
    @State private var outputUnit:Dimension = UnitTemperature.celsius
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
    let formatter: MeasurementFormatter


    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Conversion", selection: $selectedUnits) {
					ForEach(conversions, id: \.self) {
                        Text($0)
                    }
                }
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Amount to convert")
                }
                
                
                Section {
                    Text(result)
                    Picker("Convert to", selection: $outputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Converted Unit")
                }
            }
            .navigationTitle("Convert Temperature")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { newSelection in let units = unitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
