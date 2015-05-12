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
    
    @IBOutlet weak var fansButton: UIButton!
    @IBOutlet weak var artistsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
// MARK: - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "artistLogin") {
            UIView.animateWithDuration(0.2, delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { self.applicationLogoImageView.transform = CGAffineTransformMakeTranslation(0.0, 80)},
                completion: nil)
        }
        // Pass the selected object to the new view controller.
        
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
