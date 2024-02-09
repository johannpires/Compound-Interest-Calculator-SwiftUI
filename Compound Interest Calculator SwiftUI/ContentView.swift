//
//  ContentView.swift
//  Compound Interest Calculator SwiftUI
//
//  Created by Johann Pires on 07/02/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter Details")) {
                    TextField("Initial Amount", text: $viewModel.principalInput)
                        .keyboardType(.decimalPad)
                    TextField("Rate of Interest (% p.a.)", text: $viewModel.rateInput)
                        .keyboardType(.decimalPad)
                    TextField("Time (years)", text: $viewModel.timeInput)
                        .keyboardType(.decimalPad)
                    TextField("Monthly Contribution", text: $viewModel.monthlyContributionInput)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Calculate") {
                        viewModel.calculate()
                    }
                }

                if let formattedResult = viewModel.formattedResult, !formattedResult.isEmpty {
                    Section(header: Text("Result")) {
                        Text(formattedResult)
                    }
                }
            }
            .navigationBarTitle("Compound Interest Calculator", displayMode: .inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
