//
//  ViewController.swift
//  Module 3.a
//
//  Created by Sarah Pham on 6/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageHolder: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onWarEaglePressed(_ sender: UIButton) {
        imageHolder.image = #imageLiteral(resourceName: "auburn_logo")
    }
    
    @IBAction func onSECPressed(_ sender: UIButton) {
        imageHolder.image = #imageLiteral(resourceName: "southereastern_conference_logo")
    }
    
    @IBAction func onRollTidePressed(_ sender: UIButton) {
        imageHolder.image = #imageLiteral(resourceName: "roll_tide_logo")
    }
    
}

