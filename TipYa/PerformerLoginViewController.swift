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
    @IBOutlet weak var tipyaLogoImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bypassFirebaseLoginButton: UIButton!
    
    let firebaseUtility:FirebaseUtility = FirebaseUtility()
    
    @IBOutlet weak var backButton: UIButton!
    
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
        if sender.identifier == "firebaseLogin" && firebaseWorks == true {
            var successfulLogin:Bool = firebaseUtility.attemptNormalUserLogin(usernameField.text, password: passwordField.text)
            if successfulLogin {
                self.performSegueWithIdentifier("loginComplete", sender: self)
            }
        }
        if sender.identifier == "bypassFirebaseLogin" {
            self.performSegueWithIdentifier("noFirebaseLogin", sender: self)
        }
    }
    
    @IBAction func signup(sender: AnyObject) {
        firebaseUtility.createAccount(usernameField.text, password: passwordField.text)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // pass data to next view
        if (segue.identifier != "backFromArtistLogin") {
            if (segue.identifier == "firebaseLogin") {
                let viewController:PerformanceControlViewController = segue.destinationViewController as! PerformanceControlViewController
                viewController.authData = sender as? FAuthData
            }
            
            UIView.animateWithDuration(0.2, delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { self.tipyaLogoImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.609375, 1.609375), CGAffineTransformMakeTranslation(0.0, -13.0))},
                completion: nil)
        } else {
            UIView.animateWithDuration(0.2, delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { self.tipyaLogoImageView.transform = CGAffineTransformMakeScale(2.0, 2.0)},
                completion: nil)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}

