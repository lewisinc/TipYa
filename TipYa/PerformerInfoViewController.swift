//
//  PerformerInfoViewController.swift
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class PerformerInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var infoView: UIView!
    
    @IBOutlet weak var aboutField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchesBegan(touches:NSSet, event:UIEvent){
            self.aboutField.resignFirstResponder()
        
    }
    
    
    @IBAction func textFieldShouldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }
}