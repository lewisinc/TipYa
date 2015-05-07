//
//  SpectatorViewController.swift
//  TipYa
//
//  Created by Paul Wren on 5/6/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth

class SpectatorViewController: UIViewController {

    var verifiedPerformers = [PerfomerIdentity]()
    
    let tvc :UITableViewController, UITableViewDelegate, UITableViewDataSource
    
    @IBOutlet weak var refreshNearbyPerformances: UIButton!
    @IBAction func scanForPerformers(sender: AnyObject) {
        spectatorBluetoothUtility?.centralManager?.scanForPeripheralsWithServices([performerServicesUUID], options: nil)
        println("SCANNING!")
        println(spectatorBluetoothUtility?.centralManager?.state)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var number :Int? = verifiedPerformers.count + 1
        return number

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        verifiedPerformers.count
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reusableCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvc = UITableViewController.init(UITableViewStylePlain)
        tvc.tableView.reloadData()
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
