//
//  ContentView.swift
//  TimeConversion
//
//  Created by Bruce Lopez on 7/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTime: Int?
    @State private var convertionRate = 60
    @FocusState private var timeIsFocused: Bool
    @State private var selectedInputUnit = "Minutes"
    @State private var timeUnit = ["Seconds", "Minutes", "Hours"]
    @State private var selectedOutputUnit = "Seconds"
    
    var conversion: Double {
        let inputValue = Double(inputTime ?? 0)
        var tempConveted: Double

        if selectedInputUnit == "Minutes" {
            tempConveted =  inputValue * Double(convertionRate)
        } else if selectedInputUnit == "Hours" {
            tempConveted =  inputValue * Double(convertionRate) * Double(convertionRate)
        } else {
            tempConveted = inputValue
        }
        
        return tempConveted
    }
    
    var outputConversion: String {
    var tempOutput: Double = conversion
        if selectedOutputUnit == "Minutes" {
            tempOutput =  conversion / Double(convertionRate)
        } else if selectedOutputUnit == "Hours" {
            tempOutput =  conversion / ( Double(convertionRate) * Double(convertionRate))
        }
        return String(format: "%g", tempOutput)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter time", value: $inputTime, format: .number)
                        .keyboardType(.numberPad).focused($timeIsFocused)
                    
                    Picker("Time unit selector?", selection: $selectedInputUnit) {
                                   ForEach(timeUnit, id: \.self) {
                                       Text($0)
                                   }
                               }
                               .pickerStyle(.segmented)
                } header: {
                    Text("What time unit would you like to convert?")
                    
                }
                Section {
                    Text("\(outputConversion) \(selectedOutputUnit)")
                    Picker("Time unit selectored?", selection: $selectedOutputUnit) {
                                   ForEach(timeUnit, id: \.self) {
                                       Text($0)
                                   }
                               }
                               .pickerStyle(.segmented)
                }header: {
                    Text("Output time unit")
                    
                }
            }
            .navigationTitle("TimeConvert+")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        timeIsFocused = false
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
