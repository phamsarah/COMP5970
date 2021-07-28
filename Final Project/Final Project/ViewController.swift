//
//  ViewController.swift
//  Final Project
//
//  Created by Sarah Pham on 7/27/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculateTipButton: UIButton!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTipClicked(_ sender: Any) {
        
        let billAmount:Double = Double(billAmountTextField.text!)!
        
        // Divided by 100 to get decimal place
        let tipAmount:Double = (Double(tipPercentTextField.text!)! / 100) * billAmount

        tipAmountLabel.text = String(format: "$%.02f", tipAmount)
        billTotalLabel.text = String(format: "$%.02f", billAmount + tipAmount)
        
    }
}

