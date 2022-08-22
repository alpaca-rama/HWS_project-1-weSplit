//
//  ContentView.swift
//  WeSplit
//
//  Created by Luca Capriati on 2022/07/06.
//
// Project 1 - Challange 1 - Add a header to the third section, saying “Amount per person”
// Project 1 - Challange 2 - Add another section showing the total amount for the check – i.e., the original amount plus tip value,
//  without dividing by the number of people.
// Project 1 - Challange 3 - Change the tip percentage picker to show a new screen rather than using a segmented control,
//  and give it a wider range of options – everything from 0% to 100%.
//  Tip: use the range 0..<101 for your range rather than a fixed array.
// Project 4 - Challange 1 - Go back to project 1 and use a conditional modifier to change the total amount text view to red
//  if the user selects a 0% tip.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Project 1 - Challange 2
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
    
    // Project 1 - Extra Challange
    var localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    // Project 1 - Challange 3
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // Project 1 - Challange 2
                Section {
                    Text(grandTotal, format: localCurrency)
                        //  Project 4 - Challange 1
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total Amount")
                }
                
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                } header: { // Project 1 - Challange 1: Add a header to the third section, saying “Amount per person”
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
