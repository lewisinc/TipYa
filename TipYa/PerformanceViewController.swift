//
//  PerformanceViewController
//  TipYa
//
//  Created by Justin Oroz on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class PerformanceViewController:UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    @IBOutlet weak var imageButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    var authData: FAuthData?
    
    var profImage: UIImage?
    var user: Firebase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        user = accounts.childByAppendingPath(authData!.uid)
        user!.observeSingleEventOfType(.Value, withBlock: { snapshot in

        var json = snapshot.value as NSDictionary!
            
            
            //grab image
        
        
    })

    
        //load info from firebase
        println(authData!.uid)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let mask = UIImage(named: "Circle_Mask")
        
        var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage //2
        imageButton.contentMode = .ScaleAspectFit //3
        self.profImage = maskImage(chosenImage, maskImage: mask!)
        //self.profImage = chosenImage
        
        imageButton.imageView?.image = profImage //4
        imageButton.imageView?.highlightedImage = profImage //4
        
        var imageData = UIImagePNGRepresentation(profImage)
        
        
        user!.childByAppendingPath("image").setValue("\(imageData)")
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    @IBAction func pickImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = true //2
        imagePicker.sourceType = .PhotoLibrary //3
        presentViewController(imagePicker, animated: true, completion: nil)//
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        //upload to firebase
        println("i've got an image");
    }
    
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
            let viewController:PerformerInfoViewController = segue.destinationViewController as PerformerInfoViewController
            viewController.authData = self.authData
            // pass data to next view
        }
    }
    
}