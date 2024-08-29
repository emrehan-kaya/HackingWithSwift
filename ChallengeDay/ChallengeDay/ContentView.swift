//
//  ContentView.swift
//  ChallengeDay
//
//  Created by Emrehan Kaya on 28.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    let TimeConversion = ["second", "minute", "hour", "day"]
    @State var firstSelectConversion = "second"
    @State var secondSelectConversion = "minute"
    @State var userInput: Double = 0.0
    
    var inputConverted : Double {
        let finalInput : Double = userInput
        
        switch firstSelectConversion {
        case "second":
            return finalInput
        case "minute":
            return finalInput * 60
        case "hour":
            return finalInput * 3600
        case "day":
            return finalInput * 86400
        default:
            return finalInput
        }
    }
        
        var outputConverted: Double {
            
            let finalOutput: Double = inputConverted
            
            switch secondSelectConversion {
            case "second":
                return finalOutput
            case "minute":
                return finalOutput / 60
            case "hour":
                return finalOutput / 3600
            case "day":
                return finalOutput / 86400
            default:
                return finalOutput
            }
            
        }
     
    @FocusState private var isFocused : Bool
    
    
var body: some View {
        NavigationStack {
            List {
                Section("from") {
                    Picker("",selection: $firstSelectConversion) {
                        ForEach(TimeConversion, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("to") {
                    Picker("",selection: $secondSelectConversion) {
                        ForEach(TimeConversion, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("enter a value") {
                    TextField("enter a value",value: $userInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                
                Section("Result") {
                    Text(outputConverted.formatted())
                }
                
            }
            .navigationTitle("Time Transformations")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
