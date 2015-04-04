// Playground - noun: a place where people can play

import UIKit
import Foundation
import Firebase
var str = "Hello, playground"

var rootReference = Firebase(url:"https://tipyalahacks2015.firebaseio.com")
var child = "test"
var key = "answer"

rootReference.observeEventType(.Value, withBlock: { snapshot in
    println(snapshot.value)
    }, withCancelBlock: { error in
        println(error.description)
})



rootReference.childByAppendingPath(child).setValue(key)



