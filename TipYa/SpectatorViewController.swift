//
//  SpectatorViewController.swift
//  TipYa
//
//  Created by Paul Wren on 5/6/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit

class SpectatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var verifiedPerformers :Array<PerformerIdentity>? = nil
    
    @IBOutlet weak var refreshNearbyPerformances: UIButton!
    /*@IBAction func scanForPerformers(sender: AnyObject) {
        spectatorBluetoothUtility?.centralManager?.scanForPeripheralsWithServices([performerServicesUUID], options: nil)
        println("SCANNING!")
        println(spectatorBluetoothUtility?.centralManager?.state)
    }*/
    
    /* MARK: -TableView Goodness
    Funtions for storyboard are below
    */
    
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
        
        //verifiedPerformers = [PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil), PerformerIdentity(name: "Bill", image: nil, text: "I'm cool", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil)]
        
        tableView.registerNib(UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: spectCellIdentifier)
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Spectator Utility Delegate Methods
    
    func foundPerformer(performer:PerformerIdentity) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
