//
//  Playground created by Sarah Pham on 6/3/2021
// Please check out the ViewController.swift version :)
//
import UIKit

func mortgageCalculator(loanAmount: Int, numPayments: Int, interestRate: Float) -> Float {
    let v = Float(loanAmount)
    let n = Int(numPayments)
    let interestRate = Float(interestRate)
    
    let i = (interestRate / 100.0) / 12.0

    // n = numPayments, i = interestRate, v = loanAmount
    var denominator: Float = 0.0
    
    // calculate payment
    for j in 1...n {
        denominator = (denominator + (1.0 / pow((1.0 + i), Float(j))))
    }
    
    let payment =  v / denominator
    
    return payment
    
}

// Test/Grade the calculate function here
mortgageCalculator(loanAmount: 20000, numPayments: 72, interestRate: 4.4)
mortgageCalculator(loanAmount: 150000, numPayments: 360, interestRate: 5.0)
