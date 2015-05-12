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
    
    @IBOutlet var tableView: UITableView!
    let spectCellIdentifier = "spectCell"
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if var count :Int = self.verifiedPerformers?.count {
            println("Count Success: \(count)")
            return count
        } else {
            println("Count Failed")
            return 1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if let cell: TableViewCell = tableView.dequeueReusableCellWithIdentifier(spectCellIdentifier) as? TableViewCell {
            // Configure the cell for this indexPath
            
            let item = self.verifiedPerformers?[indexPath.row]
            
            cell.titleLabel.text = item?.name
            cell.subtitleLabel.text = item?.bioText
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            
            println("Final Cell: #\(indexPath.row) = #\(self.verifiedPerformers?[indexPath.row].name)")
            println("Name = \(cell.titleLabel.text)")
            println("Text = \(cell.subtitleLabel.text)")
            
            return cell
            
        } else {
            
            return UITableViewCell()
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerNib(UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: spectCellIdentifier)
        // Do any additional setup after loading the view.
        
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 60.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - SpectatorUtilityDelegate Function Definitions
    func foundNewPerformer(performer:PerformerIdentity) {
        verifiedPerformers?.append(performer)
        tableView.reloadData()
    }
    
    func clear() {
        
        let rowsToDelete: NSMutableArray = []
        
        for (var i = 0; i < self.verifiedPerformers?.count; i++) {
            rowsToDelete.addObject(NSIndexPath(forRow: i, inSection: 0))
        }
        
        tableView.deleteRowsAtIndexPaths(rowsToDelete as [AnyObject], withRowAnimation: .Automatic)
        
    }
    
    func checkIDs() -> PerformerIdentity {
        //let int :Int = 0
        return PerformerIdentity()
    }
    
    /* MARK: - Navigation
    In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}