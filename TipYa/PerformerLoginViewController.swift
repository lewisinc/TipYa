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
        
        let ref = Firebase(url: "https://tipyalahacks2015.firebaseio.com/")
        
        ref.authUser(usernameField.text, password: passwordField.text) {
            error, authData in
            if (error != nil) {
                // an error occurred while attempting login
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
                    case .UserDoesNotExist:
                        println("Handle invalid user")
                    case .InvalidEmail:
                        println("Handle invalid email")
                    case .InvalidPassword:
                        println("Handle invalid password")
                    default:
                        println("Handle default situation")
                    }
                }
            } else {
                // User is logged in
                self.performSegueWithIdentifier("loginComplete", sender: authData)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if (segue.identifier == "loginComplete") {
            let viewController:PerformanceViewController = segue.destinationViewController as PerformanceViewController
            viewController.authData = sender as FAuthData
            // pass data to next view
        }
    }
}

