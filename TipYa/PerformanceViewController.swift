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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage //2
        imageButton.contentMode = .ScaleAspectFit //3
        imageButton.imageView?.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    @IBAction func pickImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = false //2
        imagePicker.sourceType = .PhotoLibrary //3
        presentViewController(imagePicker, animated: true, completion: nil)//
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}