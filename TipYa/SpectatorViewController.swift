//
//  SpectatorViewController.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import UIKit
import CoreBluetooth

class SpectatorViewController: UIViewController {

    var foundPerformers:[PerformerIdentity]?
    
    @IBOutlet weak var refreshNearbyPerformances: UIButton!
    
    @IBAction func scanForPerformers(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foundPerformers = [PerformerIdentity]()
        populateTableView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateTableView() {
        
        var imageOne:UIImage = UIImage(named: "happy-face")!
        var uuidOne:CBUUID = CBUUID(string: "9A2365C7-B3D3-449D-AF84-2381EC4E60C3")
        foundPerformers?.append(PerformerIdentity(name: "Charles", image: imageOne, text: "I'm a real band, honest", uuidKey: uuidOne))
        
    }
    
    func addCellToTableView(image:UIImage!, name:String!) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}