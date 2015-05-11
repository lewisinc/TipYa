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
            return count
        } else {
            return 1
        }
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return basicCellAtIndexPath(indexPath)
    
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> TableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(spectCellIdentifier) as! TableViewCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    
    }
    
    func setTitleForCell(cell:TableViewCell, indexPath:NSIndexPath) {
        
        let item :PerformerIdentity? = verifiedPerformers?[indexPath.row]
        if var temp = item?.name {
            cell.titleLabel.text = temp
        } else {
            cell.titleLabel.text = "None Found"
        }
    }
    
    func setSubtitleForCell(cell:TableViewCell, indexPath:NSIndexPath) {
        let item :PerformerIdentity? = verifiedPerformers?[indexPath.row]
        if var temp = item?.bioText {
            cell.subtitleLabel.text = temp
        } else {
            cell.subtitleLabel.text = "No Description"
        }
    }
    
    /*if let subtitle = subtitle {
    
    // Some subtitles are really long, so only display the first 200 characters
    if subtitle.length > 200 {
    cell.subtitleLabel.text = "\(subtitle.substringToIndex(200))..."
    
    } else {
    cell.subtitleLabel.text = subtitle as String
    }
    
    } else {
    cell.subtitleLabel.text = ""
    }
    }*/

    /*func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }*/
    
    /* MARK:
        UIViewController funtions are below here
    */
    
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
