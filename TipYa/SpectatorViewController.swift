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

    var verifiedPerformers :Array<PerformerIdentity>?
    
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
        
        let cell :TableViewCell = basicCellAtIndexPath(indexPath)
        
        println("Final Cell: #\(indexPath.row) = #\(self.verifiedPerformers?[indexPath.row].name)")
        println("Name = \(cell.titleLabel.text)")
        println("Text = \(cell.subtitleLabel.text)")
        
        return cell as UITableViewCell
    
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> TableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(spectCellIdentifier) as! TableViewCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        
        println("Gotten Cell: #\(indexPath.row) = #\(self.verifiedPerformers?[indexPath.row].name)")
        
        return cell
    }
    
    
    func setTitleForCell(cell:TableViewCell, indexPath:NSIndexPath) {
        
        let item :PerformerIdentity? = self.verifiedPerformers?[indexPath.row]
        
        if cell.titleLabel == nil {
            println("Error TitleLabel = nil")
            cell.titleLabel = UILabel()
        }
        
        if var temp = item {
            cell.titleLabel.text = temp.name
        } else {
            cell.titleLabel.text = "None Found"
        }
    }
    
    func setSubtitleForCell(cell:TableViewCell, indexPath:NSIndexPath) {
        
        let item :PerformerIdentity? = verifiedPerformers?[indexPath.row]
        
        if cell.subtitleLabel == nil {
            println("Error SubtitleLabel = nil")
            cell.subtitleLabel = UILabel()
        }
        
        if var temp = item {
            cell.subtitleLabel.text = temp.bioText
        } else {
            cell.subtitleLabel.text = "No Description"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //verifiedPerformers = ["apple","juice","fruit"]
        
        verifiedPerformers = [PerformerIdentity(name: "Chad", image: nil, text: "I'm definitely a band", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil), PerformerIdentity(name: "Bill", image: nil, text: "I'm cool", facebook: nil, youtube: nil, otherWebsite: nil, idKey: nil)]
        
        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "spectCell")
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
