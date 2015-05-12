//
//  PerformerInfoViewController.swift
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class PerformerInfoViewController: UIViewController, UITextFieldDelegate {
    
    
    var authData: FAuthData?
    var user: Firebase?
    var json: NSDictionary?
    var userObj: PerformerIdentity?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        user = accounts.childByAppendingPath(authData!.uid)
        
        
        
        user!.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if (snapshot.hasChildren() == true) {
                self.json = snapshot.value as! NSDictionary!
                
                if (self.json?.valueForKey("name") != nil) {
                    self.nameField.text = self.json!.valueForKey("name")! as! String
                }
                
                if (self.json?.valueForKey("description") != nil) {
                    self.descripField.text  = self.json!.valueForKey("description")! as! String
                }
                
                println(self.json!.valueForKey("name")!)
            }
            
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchesBegan(touches:NSSet, event:UIEvent){
        self.aboutField.resignFirstResponder()
        
    }
    
    
    /*
    @IBAction func textFieldShouldReturn(sender: UITextField) {
    sender.resignFirstResponder()
    }
    */
    
    @IBOutlet weak var descripField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func updateFirebase(sender: AnyObject) {
        
        if (nameField.text != ""){
            user!.childByAppendingPath("name").setValue(nameField.text);
        }
        if (descripField.text != ""){
            user!.childByAppendingPath("description").setValue(descripField.text);
        }
    }
    
}