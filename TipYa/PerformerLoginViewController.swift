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
        
        accounts.authUser(usernameField.text, password: passwordField.text) {
            error, authData in
            if (error != nil) {
                // an error occurred while attempting login
                let alert = UIAlertView()
                alert.title = "Error"
                
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
                    case .UserDoesNotExist:
                        println("Handle invalid user")
                        alert.message = "User does not exist"
                    case .InvalidEmail:
                        println("Handle invalid email")
                        alert.message = "Invalid Login"
                    case .InvalidPassword:
                        println("Handle invalid password")
                        alert.message = "Invalid Login"
                    default:
                        println("Handle default situation")
                        alert.message = "Something went wrong"
                    }
                    alert.addButtonWithTitle("OK")
                    alert.show()
                }
            } else {
                // User is logged in
                self.performSegueWithIdentifier("loginComplete", sender: authData)
            }
        }
        
    }
    
    @IBAction func signup(sender: AnyObject) {
        let alert = UIAlertView()

        accounts.createUser(usernameField.text, password: passwordField.text,
            withValueCompletionBlock: { error, result in
                
                if error != nil {
                    // There was an error creating the account
                    println("Error occurred in Account Creation")
                    alert.title = "Error"
                    alert.message = "Try Again"
                    alert.addButtonWithTitle("OK")
                    alert.show()
                } else {
                    let uid = result["uid"] as? String
                    println("Successfully created user account with uid: \(uid)")
                    alert.title = "Success"
                    alert.message = "Please Login"
                    alert.addButtonWithTitle("OK")
                    alert.show()
                }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "loginComplete") {
            let viewController:PerformanceViewController = segue.destinationViewController as! PerformanceViewController
            viewController.authData = sender as? FAuthData
            // pass data to next view
        }
    }
}

