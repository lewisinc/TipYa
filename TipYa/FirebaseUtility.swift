//
//  FirebaseUtility.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import Foundation
import UIKit

let rootReference = Firebase(url:"https://tipyalahacks2015.firebaseio.com")
let accounts = Firebase(url: "https://tipyalahacks2015.firebaseio.com/Accounts")

let firebaseWorks: Bool = false
class FirebaseUtility {
    var loggedInUserData:FAuthData?

    func attemptUserLogin(name:String!, password:String!) -> Bool {
        var returnVal:Bool?
        
        accounts.authUser(name, password: password, withCompletionBlock: { error, authData -> Void in
            if error != nil {
                
                switch (error) {
                    case .UserDoesNotExist:
                        println("Handle invalid user")
                        alert.message = "User does not exist"
                    case .InvalidEmail:
                        println("Handle invalid email")
                        alert.message = "Invalid Login"
                    case .InvalidPassword:
                        println("Handle invalid password")
                        alert.message = "Invalid Login"
                    default:
                        println("Handle default situation")
                        alert.message = "Something went wrong"
                    }
                alert.addButtonWithTitle("Unsuccessful login.")
                alert.show()
            } else {
            
            }
        })
//        accounts.authUser(name, password: password, withCompletionBlock: { error, authData in
//            if (error != nil) {
//                // an error occurred while attempting login
//                let alert = UIAlertView()
//                alert.title = "Error"
//                returnVal = false
//
//                if let errorCode = FAuthenticationError(rawValue: error.code) {
//                    switch (errorCode) {
//                    case .UserDoesNotExist:
//                        println("Handle invalid user")
//                        alert.message = "User does not exist"
//                    case .InvalidEmail:
//                        println("Handle invalid email")
//                        alert.message = "Invalid Login"
//                    case .InvalidPassword:
//                        println("Handle invalid password")
//                        alert.message = "Invalid Login"
//                    default:
//                        println("Handle default situation")
//                        alert.message = "Something went wrong"
//                    }
//                    alert.addButtonWithTitle("Unsuccessful login.")
//                    alert.show()
//                }
//            } else {
//                println("Logged in as \(name)")
//                returnVal = true
//            }
//        })
        
        return returnVal!
    }
    
}