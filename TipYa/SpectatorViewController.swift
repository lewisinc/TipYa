//
//  SpectatorViewController.swift
//  TipYa
//
//  Created by Paul Wren on 5/6/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth

class SpectatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var verifiedPerformers = [String]()
    var spectatorBluetoothUtility :SpectatorUtility?
    
    @IBOutlet weak var refreshNearbyPerformances: UIButton!
    @IBAction func scanForPerformers(sender: AnyObject) {
        spectatorBluetoothUtility?.centralManager?.scanForPeripheralsWithServices([performerServicesUUID], options: nil)
        println("SCANNING!")
        println(spectatorBluetoothUtility?.centralManager?.state)
    }
    
    /* MARK: -TableView Goodness
    Funtions for storyboard are below
    */
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 0
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.verifiedPerformers[indexPath.row]
        
        return cell
    }
    
    /* MARK:
        UIViewController funtions are below here
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verifiedPerformers = ["apple","juice","fruit"]
        
        //verifiedPerformers.append(PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil))
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
