//
//  ViewModel.swift
//  Compound Interest Calculator SwiftUI
//
//  Created by Johann Pires on 07/02/2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var principalInput = ""
    @Published var rateInput = ""
    @Published var timeInput = ""
    @Published var monthlyContributionInput = ""
    @Published var formattedResult: String?
    
    func calculate() {
        guard let principal = Double(principalInput),
              let rate = Double(rateInput),
              let time = Double(timeInput),
              let monthlyContribution = Double(monthlyContributionInput)
        else { return }
        
        let result = compoundInterest(principal: principal, rate: rate, time: time, monthlyContribution: monthlyContribution)
        formattedResult = formatResult(result: result)
    }
    
    private func compoundInterest(principal: Double, rate: Double, time: Double, monthlyContribution: Double) -> CalculationResult {
        var amount = principal
        let annualRate = (1 + rate/100)
        let monthlyRate = pow(annualRate, 1/12) - 1
        
        for _ in 1...Int(time*12) {
            amount *= (1 + monthlyRate)
            amount += monthlyContribution
        }
        
        let totalValue = amount
        let compoundInterest = totalValue - principal - (monthlyContribution * time * 12)
        
        return CalculationResult(compoundInterest: compoundInterest, totalValue: totalValue)
    }
    
    private func formatResult(result: CalculationResult) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let compoundInterestFormatted = numberFormatter.string(for: result.compoundInterest) ?? ""
        let totalValueFormatted = numberFormatter.string(for: result.totalValue) ?? ""
        
        return "Once your investment compounds, you'll have the total amount of: \(totalValueFormatted). The compounded earnings alone will be \(compoundInterestFormatted)."
    }
}
