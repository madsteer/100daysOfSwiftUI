//
//  ContentView.swift
//  UnitConversions
//
//  Created by Cory Steers on 1/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tempUnit = "Fahrenheit"
    @State private var temperature = 32.0
    @State private var fahrenheit = 32.0
    @State private var celsius = 0.0
    @State private var kelvin = 273.15
    
    @FocusState private var inputIsFocused: Bool
    
    let tempUnits = [ "Fahrenheit", "Celsius", "Kelvin" ]
    
    func calculateInput() {
        switch tempUnit {
        case "Fahrenheit":
            fahrenheit = temperature
            let f = Measurement(value: temperature, unit: UnitTemperature.fahrenheit)
            celsius = f.converted(to: .celsius).value
            kelvin = f.converted(to: .kelvin).value
        case "Celsius":
            celsius = temperature
            let c = Measurement(value: celsius, unit: UnitTemperature.celsius)
            fahrenheit = c.converted(to: .fahrenheit).value
            kelvin = c.converted(to: .kelvin).value
        default: // kelvin
            kelvin = temperature
            let k = Measurement(value: kelvin, unit: UnitTemperature.kelvin)
            celsius = k.converted(to: .celsius).value
            fahrenheit = k.converted(to: .fahrenheit).value
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Picker("Input Unit", selection: $tempUnit) {
                            ForEach(tempUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        HStack {
                            Text("Input: ")
                            TextField("Temperature", value: $temperature, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($inputIsFocused)
                        }
                    }
                } header: {
                    Text("Temperature Conversions")
                }
                Section {
                    Text("Fahrenheit: \(fahrenheit.formatted()) º")
                    Text("Celsius: \(celsius.formatted()) º")
                    Text("Kelvin: \(kelvin.formatted())")
                }
                .navigationTitle("Unit Conversion")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            inputIsFocused = false
                            calculateInput()
                        }
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
