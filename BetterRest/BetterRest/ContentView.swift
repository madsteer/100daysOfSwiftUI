//
//  ContentView.swift
//  BetterRest
//
//  Created by Cory Steers on 3/23/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWaketime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWaketime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var bedTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600 // in seconds
            let minute = (components.minute ?? 0) * 60 // in seconds
            
            let prediciton = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            return wakeUp - prediciton.actualSleep
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
            
            return wakeUp
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                } header: {
                    Text("When do you want to wake up?")
                        .bold()
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .bold()
                }
                
                Section {
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0) cups")
                        }
                    }
                    .labelsHidden()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                } header: {
                    Text("Daily coffee intake")
                        .bold()
                }

                Section {
                    Text(bedTime.formatted(date: .omitted, time: .shortened))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .font(.title)
                        .bold()
                } header: {
                    Text("Your ideal bedtime")
                        .font(.title)
                        .bold()
                }
            }
            .navigationTitle("Better Rest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
