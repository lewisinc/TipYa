//
//  PerformerIdentity.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth
import Security

class PerformerIdentity: NSObject {
    var name:String?            // Name
    var image:UIImage?          // Image
    var bioText:String?         // Biography
    var facebookLink:String?    // Facebook
    var youtubeLink:String?     // Youtube
    var miscWebsite:String?     // Other Miscellaneous Website
    var identityKey:CBUUID?
    
    override init() {
        super.init()
    }
    
    init(name:String?, image:UIImage?, text:String?, facebook:String?, youtube:String?, otherWebsite:String?, idKey:CBUUID?) {
        super.init()
        self.name = name
        self.image = image
        self.bioText = text
        self.facebookLink = facebook
        self.youtubeLink = youtube
        self.miscWebsite = otherWebsite
        self.identityKey = idKey
    }
    
    // IN THE FUTURE
    /*
        It will be possible to save a users data (not another user's) to NSUserDefaults for persistence across relaunches.
    
    func saveToNSUserDefaults(identity:PerformerIdentity!)
    func loadFromNSUserDefaults()
    */
    
}
