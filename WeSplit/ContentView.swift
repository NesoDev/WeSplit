//
//  ContentView.swift
//  CourseSwiftUI
//
//  Created by Ever Avendaño on 28/12/25.
//

import SwiftUI

struct ContentView: View {
    let students : [String] = ["User1", "User2", "User3"]
    @State private var checkAmount: Double = 0.0
    @State private var numberPeople: Int = 0
    @State private var tipPercentage: Int = 10
    @State private var tipPercentages: [Int] = [10, 15, 20, 25, 0]
    @FocusState private var isEditing: Bool
    private var totalPerPerson: Double {
        let countPeople = Double(numberPeople + 2)
        let totalTip = checkAmount * Double(tipPercentage) / 100
        let totalAmount = checkAmount + totalTip
        return totalAmount / countPeople
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isEditing)
                    Picker("Number people", selection: $numberPeople) {
                        ForEach(2..<5) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total per person:") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                if isEditing {
                    Button("Done") {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
