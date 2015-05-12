//
//  Tests.swift
//  TipYa
//
//  Created by Paul Wren on 5/12/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

class Tests: AnyObject {
    func IdentityPassAndLoad() {
        
        /*
        1. Generate random identity with random string values for each characeristic
        2. Append identity to Array verifiedPerformers in SpectatorUtility
        3. Assert that the information SpectatorTableViewController uses to build a cell is the same as the passed in information for all randomly chosen possiblilities for identity up to 10,000 characters.
        */
        
        var randomIdentitys :Array<PerformerIdentity> = [PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil)]
        
        let spectView: SpectatorViewController = SpectatorViewController()
        //verifiedPerformers = [PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil), PerformerIdentity(name: "Bill", image: nil, text: "I'm cool", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil)]
        
        spectView.foundPerformer(randomIdentitys[0])
        
        if spectView.verifiedPerformers?[0] == randomIdentitys[0] {
            println("Final identity was the same as expected")
        
        }else{
            println("Found Identity Fail")
        }
        }
    func CountTest() {
        let spectView: SpectatorViewController = SpectatorViewController()
        spectView.verifiedPerformers = [PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil), PerformerIdentity(name: "Bill", image: nil, text: "I'm cool", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil)]
        spectView.viewDidLoad()
        if spectView.tableView.numberOfRowsInSection(0) == spectView.verifiedPerformers?.count {
            println("Count Succeeded")
        } else {
            println("Count Failed")
        }
    }
}