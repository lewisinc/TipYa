//
//  TipYaTests.swift
//  TipYaTests
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//
import Foundation
import UIKit
import XCTest
import CoreBluetooth
import TipYa

class BasicBlackboxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func BluetoothConnect() {
        // This is an example of a functional test case.
        //XCTAssert(SpectatorUtility ,"Bluetooth connected with hardcoded peripheral")
    }
    
    func IdentityPassAndLoad() {
        /*
            1. Generate random identity with random string values for each characeristic
            2. Append identity to Array verifiedPerformers in SpectatorUtility
            3. Assert that the information SpectatorTableViewController uses to build a cell is the same as the passed in information for all randomly chosen possiblilities for identity up to 10,000 characters.
        */
        
        let randomIdentity :PerformerIdentity = PerformerIdentity.init(name: self.randomStringWithLength(100),image: nil ,text: self.randomStringWithLength(10000), facebook: self.randomStringWithLength(200), youtube: self.randomStringWithLength(200), otherWebsite: self.randomStringWithLength(), idkey: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD54C")
        
        //XCTAssertEqual(expression1: [T : U], <#expression2: [T : U]#>, "Final identity was the same as expected")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    //name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.!@#$%^&*_+-={}[]:';<>?,./ "
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
}

/*public class PerformerIdentity: NSObject {
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
    
}*/