//
//  PerformerLoginViewController.swift
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit


class PerformerLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func textFieldShouldReturn(sender: UITextField) {

        if (sender.restorationIdentifier == "username") {
            sender.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if (sender.restorationIdentifier == "password") {
            sender.resignFirstResponder()
        } else {
            println("wtf")
        }
    }

    @IBAction func login(sender: AnyObject) {
        // Get a reference to our posts
        let accounts = Firebase(url:"https://tipyalahacks2015.firebaseio.com/Accounts")
        
        
    }

}