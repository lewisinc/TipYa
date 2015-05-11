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


class FirebaseUtility {

    let firebaseWorks: Bool = false
    
    var loggedInUserData:FAuthData?
    
    func configure(identity: AnyObject) {
        if identity.isMemberOfClass(PerformerIdentity) {
            
        }
        if identity.isMemberOfClass(SpectatorIdentity) {
            println("FirebaseUtility does not yet support Spectator interactivity.")
        }
    }
    
    func attemptNormalUserLogin(name:String!, password:String!) -> Bool {
        var loginAttemptResult:Bool?
        
        accounts.authUser(name, password: password, withCompletionBlock: {
            (error, authData) in
            if (error != nil) {
                let alert = UIAlertView()
                alert.title = "Error"
                loginAttemptResult = false
                
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
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
                }
                
                alert.addButtonWithTitle("Unsuccessful login.")
                alert.show()
                
            } else {
                loginAttemptResult = true
                self.loggedInUserData = authData
            }
        })
        
        return loginAttemptResult!
    }
    
    func createAccount(username:String!, password: String!) {
        
        let alert:UIAlertView = UIAlertView()
        
        accounts.createUser(username, password: password,
        withValueCompletionBlock: { error, result in
        
            if error != nil {
                // There was an error creating the account
                println("Error occurred in Account Creation")
                alert.title = "Error"
                alert.message = "Try Again"
                alert.addButtonWithTitle("OK")
            alert.show()
            } else {
                let uid = result["uid"] as? String
                println("Successfully created user account with uid: \(uid)")
                alert.title = "Success"
                alert.message = "Please Login"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
            
        })
    }
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
    
}