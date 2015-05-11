//
//  PerformerLoginViewController.swift
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class PerformerLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tipyaLogo: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bypassFirebaseLoginButton: UIButton!
    
    let firebaseUtility:FirebaseUtility = FirebaseUtility()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameField.delegate = self
        passwordField.delegate = self
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.restorationIdentifier == "emailTextfield") {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if (textField.restorationIdentifier == "passwordTextfield") {
            textField.resignFirstResponder()
        } else {
            println("Unknown TextField trying to return from editing")
        }
        
        return true
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func login(sender: AnyObject) {
        
        if sender.restorationIdentifier == "firebaseLogin" {
            let successfulLogin:Bool = firebaseUtility.attemptNormalUserLogin(usernameField.text, password: passwordField.text)
            if successfulLogin {
                self.performSegueWithIdentifier("loginComplete", sender: firebaseUtility.loggedInUserData!)
            }
        }
        if sender.restorationIdentifier == "bypassFirebaseLogin" {
            self.performSegueWithIdentifier("noFirebase", sender: nil)
        }
    }
    
    @IBAction func signup(sender: AnyObject) {
        firebaseUtility.createAccount(usernameField.text, password: passwordField.text)
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

