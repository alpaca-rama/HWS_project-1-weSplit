//
//  ContentView.swift
//  WeSplit
//
//  Created by Luca Capriati on 2022/07/06.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var tipAmount: Double {
//        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        return tipValue
    }
    
    var totalAmount: Double {
        let total = tipAmount + checkAmount
        
        return total
    }
    
    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
        let currentCode = Locale.current.currencyCode ?? "USD"
        
        return FloatingPointFormatStyle<Double>.Currency(code: currentCode)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
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
                            Text("\($0)%")
                        }
                    }
//                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave")
                }
                
                Section {
                    Text("Original Amount: \(checkAmount, format: localCurrency)")
                    Text("Tip Percentage: \(tipPercentage, format: .percent)")
                    Text("Tip Amount: \(tipAmount, format: localCurrency)")
                    Text("Total Amount: \(totalAmount, format: localCurrency)")
                } header: {
                    Text("Details")
                }
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                } header: {
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
