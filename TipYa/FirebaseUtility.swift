//
//  FirebaseUtility.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import Foundation

var rootReference = Firebase(url:"https://tipyalahacks2015.firebaseio.com")

// Attach a closure to read the data at our posts reference
rootReference.observeEventType(.Value, withBlock: { snapshot in
    println(snapshot.value)
    }, withCancelBlock: { error in
        println(error.description)
})