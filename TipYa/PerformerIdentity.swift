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
    var name:String?
    var background:String?
    var passHash:String?
    var image:UIImage?
    var bioText:String?
    var identityKey:CBUUID?
    
    override init(){
    }
    
    init(name:String!, image:UIImage!, text:String!, uuidKey:CBUUID!) {
        super.init()
        self.name = name
        self.image = image
        self.bioText = text
        self.identityKey = uuidKey
    }
    
}
