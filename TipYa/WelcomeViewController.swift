//
//  WelcomeViewController.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var applicationLogoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkPerformerAuth(sender: AnyObject) {
        
        rootReference.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated with Firebase
                
                println(authData)
            self.performSegueWithIdentifier("presenterLoggedIn", sender: authData)
            } else {
                
                println("Not Logged In")

                self.performSegueWithIdentifier("performerLogin", sender: authData)
            }
        })
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if (segue.identifier == "presenterLoggedIn") {
            let viewController:PerformanceViewController = segue.destinationViewController as! PerformanceViewController
            viewController.authData = sender as? FAuthData
            // pass data to next view
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
