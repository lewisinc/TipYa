//
//  PerformanceControlViewController
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth

class PerformanceControlViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
    
    // TextFields
    @IBOutlet weak var artistNameTextView: UITextView!
    @IBOutlet weak var facebookLinkTextView: UITextView!
    @IBOutlet weak var youtubeLinkTextView: UITextView!
    @IBOutlet weak var otherWebLinkTextView: UITextView!
    @IBOutlet weak var biographyTextView: UITextView!
    
    @IBOutlet weak var editFeedbackLabel: UILabel!
    
    
    // MARK:    - Bluetooth Properties
    let imagePicker = UIImagePickerController()
    let bluetoothUtility:PerformerUtility = PerformerUtility()
    @IBOutlet weak var toggleBluetoothButton: UIButton!
    @IBAction func toggleBluetooth(sender: UIButton) {
        if bluetoothUtility.peripheralManager?.isAdvertising == true {
            toggleBluetoothButton.backgroundColor = colorRed
            toggleBluetoothButton.titleLabel!.text = "Inactive"
            bluetoothUtility.stopAdvertising()
            println("Stopped Advertising")
            
        } else {
            bluetoothUtility.configureUtilityForIdentity(PerformerIdentity(name: artistNameTextView.text, image: imageView.image, text: biographyTextView.text, facebook: facebookLinkTextView.text, youtube: youtubeLinkTextView.text, otherWebsite: otherWebLinkTextView.text, idKey: nil))
            toggleBluetoothButton.backgroundColor = colorBlue
            toggleBluetoothButton.titleLabel!.text = "Active"
            bluetoothUtility.startAdvertising()
        }
    }


    
    // MARK:    - Firebase Properties
    var authData: FAuthData?
    
    var profImage: UIImage?
    var firebase: Firebase?
    var user:Firebase?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        artistNameTextView.delegate = self
        facebookLinkTextView.delegate = self
        youtubeLinkTextView.delegate = self
        otherWebLinkTextView.delegate = self
        biographyTextView.delegate = self
        
        if firebaseWorks {
            user = accounts.childByAppendingPath(authData!.uid)
            user!.observeSingleEventOfType(.Value, withBlock: { snapshot in
                if (snapshot.hasChildren() == true) {
                    var json = snapshot.value as! NSDictionary!
                    
                    if (json?.valueForKey("image") != nil) {
                        let base64String  = json!.valueForKey("image")! as! String
                        
                        
                        //decode image and mask it, put it in button
                        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(0))!
                        var decodedimage = UIImage(data: decodedData)!
                        self.profImage = decodedimage as UIImage!
                        
                        self.imageView.image =  self.maskImage(self.profImage!, maskImage: UIImage(named: "Circle_Mask")!)
                    }
                }
    
            })
        }
        
        //load info from firebase
        if (authData != nil) {
            println("Firebase Auth Data: \(authData!.uid)")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:    - UIImagePickerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let mask = UIImage(named: "Circle_Mask")
        println("\(mask?.size)")
        var chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage //2
        
        println("\(chosenImage.size)")
        imageButton.contentMode = .ScaleAspectFit //3
        self.profImage = maskImage(chosenImage, maskImage: mask!)
        //self.profImage = chosenImage
        
        imageView.image = profImage //4
        imageView.highlightedImage = profImage //4
        
        var imageData = UIImagePNGRepresentation(profImage)
        
        let encodedString = imageData.base64EncodedStringWithOptions(.allZeros)
        //let encodedString = imageData.base64EncodedStringWithOptions(nil)
        
        if firebaseWorks {
            user!.childByAppendingPath("image").setValue(encodedString)
        }
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = true //2
        imagePicker.sourceType = .PhotoLibrary //3
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:    - TextViewDelegate methods
    func textViewDidBeginEditing(textView: UITextView) {
        
        editFeedbackLabel.hidden = false
        textView.becomeFirstResponder()

        if textView.restorationIdentifier == "artistName" {
            
        } else if textView.restorationIdentifier == "facebookLink" {
            
        } else if textView.restorationIdentifier == "youtubeLink" {
            
        } else if textView.restorationIdentifier == "otherLink" {
            
        } else if textView.restorationIdentifier == "biographyText" {
            
        }
        
        editFeedbackLabel.text = textView.text
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if textView.restorationIdentifier == "artistName" {
            artistNameTextView.resignFirstResponder()
            facebookLinkTextView.becomeFirstResponder()
            editFeedbackLabel.text = facebookLinkTextView.text
            return false
        } else if textView.restorationIdentifier == "facebookLink" {
            facebookLinkTextView.resignFirstResponder()
            youtubeLinkTextView.becomeFirstResponder()
            editFeedbackLabel.text = youtubeLinkTextView.text
            return false
        } else if textView.restorationIdentifier == "youtubeLink" {
            youtubeLinkTextView.resignFirstResponder()
            otherWebLinkTextView.becomeFirstResponder()
            editFeedbackLabel.text = otherWebLinkTextView.text
            return false
        } else if textView.restorationIdentifier == "otherLink" {
            otherWebLinkTextView.resignFirstResponder()
            biographyTextView.becomeFirstResponder()
            editFeedbackLabel.text = biographyTextView.text
            return false
        } else if textView.restorationIdentifier == "biographyText" {
            biographyTextView.resignFirstResponder()
            editFeedbackLabel.text = ""
            editFeedbackLabel.hidden = true
            return true
        } else {
            return true
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.restorationIdentifier == "artistName" {
            editFeedbackLabel.text = textView.text
        } else if textView.restorationIdentifier == "facebookLink" {
            editFeedbackLabel.text = textView.text
        } else if textView.restorationIdentifier == "youtubeLink" {
            editFeedbackLabel.text = textView.text
        } else if textView.restorationIdentifier == "otherLink" {
            editFeedbackLabel.text = textView.text
        } else if textView.restorationIdentifier == "biographyText" {
            editFeedbackLabel.text = textView.text
        }
    }
    
    /*func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
    //upload to firebase
    println("i've got an image");
    }*/
    
    @IBAction func signOut(sender: AnyObject) {
        rootReference.unauth()
        self.performSegueWithIdentifier("signout", sender: sender)
        
    }
    
    func maskImage(image:UIImage, maskImage:UIImage) -> UIImage{
        
        var maskRef = maskImage.CGImage
        
        var mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef), nil, false);
        
        var maskedImageRef = CGImageCreateWithMask(image.CGImage, mask)
        
        var maskedImage = UIImage(CGImage: maskedImageRef)
        
        
        return maskedImage!
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "infoPane") {
            let viewController:PerformerInfoViewController = segue.destinationViewController as! PerformerInfoViewController
            viewController.authData = self.authData
            // pass data to next view
        }
        if (segue.identifier == "backToLogin") {
            UIView.animateWithDuration(0.2, delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { self.imageView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.621359, 0.621359), CGAffineTransformMakeTranslation(0.0, +13.0))},
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