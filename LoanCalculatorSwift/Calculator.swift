//
//  Calculator.swift
//  LoanCalculatorSwift
//
//  Created by Mariann on 11/4/18.
//  Copyright © 2018 Mariann. All rights reserved.
//

import UIKit




final class Calculator{

    struct BreakDown {
        let month: Int
        let totalMonthlyPayment: Double
        let principal: Double
        let interest: Double
        let remainingBalance: Double
        let fullAmount: Double

    }

    static let sharedInstance = Calculator()

    func add (a : Double, b : Double) -> Double {
        return a*b
    }

    func calPayment (fullAmount: Double, interest: Double, month: Int) -> (Double, [BreakDown]) {
        let monthlyInterest: Double = interest/12/100
        let futureInterestRate : Double = pow (_: Double(1+monthlyInterest), _: Double(month))
        let periodicPay: Double = fullAmount * (monthlyInterest * futureInterestRate)/(futureInterestRate - 1)

        let arrBreakdown = paymentBreakDown(totalMonthly: periodicPay, interest: interest, month: month, fullAmount: fullAmount)

        return (periodicPay, arrBreakdown)

    }

    private func paymentBreakDown(totalMonthly: Double, interest: Double, month: Int, fullAmount: Double) -> Array<BreakDown>{
        var monthlyBreakDownArray: [BreakDown] = []
        var monthCount: Int = 1
        var balanceRemained: Double = fullAmount
        while monthCount < month + 1 {
            let interestPower: Double = interest/12/100
            var monthlyInterestPortion: Double = balanceRemained * interestPower
            monthlyInterestPortion = Double(round(monthlyInterestPortion * 1000) /
                1000)
            var monthlyPrincipalPortion: Double = totalMonthly - monthlyInterestPortion
            monthlyPrincipalPortion = Double(round(100 * monthlyPrincipalPortion)/100)
            monthlyInterestPortion = Double(round(100 * monthlyInterestPortion)/100)
            balanceRemained = balanceRemained - monthlyPrincipalPortion
            balanceRemained = Double(round(100 * balanceRemained) / 100)
            let dataBreakDown = BreakDown(month: monthCount, totalMonthlyPayment: totalMonthly, principal: monthlyPrincipalPortion, interest: monthlyInterestPortion, remainingBalance: balanceRemained, fullAmount: fullAmount)
            monthlyBreakDownArray.append(dataBreakDown)
            monthCount += 1
        }
        return monthlyBreakDownArray
    }

}



