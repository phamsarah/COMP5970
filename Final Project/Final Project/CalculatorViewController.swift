//
//  CalculatorViewController.swift
//  Final Project
//
//  Created by Sarah Pham on 7/27/21.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var screenLabel: UILabel!
    var numberOnScreen:Double = 0;
    var previousNumber:Double = 0;
    var performingMath = false;
    var operation = 0;
    
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true{
            screenLabel.text = String(sender.tag - 1)
            numberOnScreen = Double(screenLabel.text!)!
            performingMath = false
        }
        else{
            screenLabel.text = screenLabel.text! + String(sender.tag - 1)
            numberOnScreen = Double(screenLabel.text!)!
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if screenLabel.text != "" && sender.tag != 11 && sender.tag != 16{
        
            previousNumber = Double(screenLabel.text!)!
            
            switch sender.tag{
            case 12:
                screenLabel.text = "/"
            case 13:
                screenLabel.text = "x"
            case 14:
                screenLabel.text = "-"
            case 15:
                screenLabel.text = "+"
            default:
                screenLabel.text = ""
            }
            
            operation = sender.tag
            performingMath = true
        }
        else if sender.tag == 16 {
            
            switch operation{
            case 12:
                screenLabel.text = String(previousNumber / numberOnScreen)
            case 13:
                screenLabel.text = String(previousNumber * numberOnScreen)
            case 14:
                screenLabel.text = String(previousNumber - numberOnScreen)
            case 15:
                screenLabel.text = String(previousNumber + numberOnScreen)
            default:
                screenLabel.text = ""
            }
        }
        else if sender.tag == 11 {
            screenLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}
