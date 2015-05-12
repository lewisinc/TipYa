//
//  SpectatorViewController.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth

class SpectatorViewController: UIViewController, SpectatorUtilityDelegate {

    var verifiedPerformers:[PerformerIdentity]?
    var spectatorBluetoothUtility:SpectatorUtility?
    
    @IBOutlet weak var verifiedPerformerTableView: UITableView!
    
    @IBOutlet weak var refreshNearbyPerformances: UIButton!
    @IBAction func scanForPerformers(sender: AnyObject) {
        if spectatorBluetoothUtility != nil {
            spectatorBluetoothUtility?.centralManager?.scanForPeripheralsWithServices([performerServicesUUID], options: nil)
        } else {
            println("Called scanForPerformers without a spectatorBluetoothUtility")
            spectatorBluetoothUtility = SpectatorUtility()
        }

        println("SCANNING!")
        println(spectatorBluetoothUtility?.centralManager?.state)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spectatorBluetoothUtility = SpectatorUtility()

        // Do any additional setup after loading the view.
        verifiedPerformers = [PerformerIdentity]()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateTableView() {
        
        var imageOne:UIImage = UIImage(named: "happy-face")!
        var uuidOne:CBUUID = CBUUID(string: "9A2365C7-B3D3-449D-AF84-2381EC4E60C3")
    
        verifiedPerformers?.append(PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil))
    
        // Add cell to table for each verifiedPerformer
    }
    
    func addCellToTableView(image:UIImage!, name:String!) {
        
    }
    
    func clearTableView() {
        // reset the table view to an empty state
    }
    
    /* MARK: - Navigation
        In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // MARK: - SpectatorUtilityDelegate Function Definitions
    func foundNewPerformer(identity: PerformerIdentity) {
        
        if (verifiedPerformers == nil) {
            verifiedPerformers = [PerformerIdentity]()
        }
        
        verifiedPerformers?.append(identity)
        
        addCellToTableView(identity.image, name: identity.name)
    }
    
    /* Called by this classes delegating object: SpectatorUtility,
        it shouldn't be necessary to call this directly. */
    func resetFoundPerformers() {
        verifiedPerformers = [PerformerIdentity]()
        clearTableView()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}