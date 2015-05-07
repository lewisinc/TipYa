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
    
    
    @IBAction func textFieldShouldReturn2(sender: UITextField) {
        
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
        if firebaseWorks {
            let successfulLogin:Bool = attemptUserLogin(usernameField.text, passwordField.text)
            if successfulLogin {
                self.performSegueWithIdentifier("loginComplete", sender: )
            }
        }
        else {  // Until firebaseWorks == true, do this
            self.performSegueWithIdentifier("loginComplete", sender: authData)
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
            let viewController:PerformanceControlViewController = segue.destinationViewController as! PerformanceControlViewController
            viewController.authData = sender as? FAuthData
            // pass data to next view
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

