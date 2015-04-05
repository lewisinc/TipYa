//
//  Bluetooth.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

// An Application level UUID - "Is this device running our app?"
var appUUIDKey = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD540")

// UUIDs for a performer - "Are you a performer? - Let's get your services, etc."
var performerIdentityUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD544")
var performerServicesUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD545")
var performerNameCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD546")
var performerBiographyCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD547")
var performerImageCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD548")
var performerFacebookCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD549")
var performerYoutubeCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD54A")
var performerMiscWebsiteCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD54B")

// UUIDs for a spectator - "You don't need to interact with a spectator."
var spectatorIdentityUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD550")


class PerformerUtility: NSObject, CBPeripheralManagerDelegate {

    var peripheralManager:CBPeripheralManager?
    var myIdentity:PerformerIdentity?           // Full Performer Identity
    var bluetoothServices:CBMutableService?                 // All available services
    var nameCharacteristic:CBMutableCharacteristic?         // Performers name
    var biographyCharacteristic:CBMutableCharacteristic?    // Short bio
    var chosenImageCharacteristic:CBMutableCharacteristic?  // Small photo < 10mb
    var facebookCharacteristic:CBMutableCharacteristic?     // Facebook
    var youtubeCharacteristic:CBMutableCharacteristic?      // Youtube
    var miscWebsiteCharacteristic:CBMutableCharacteristic?  // Other Miscellaneous Website
    var identityKey:CBMutableCharacteristic?                // Identity key for Firebase
    
    // Start up a peripheral manager object
    // also builds our broadcastable services
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate:self, queue:nil)
        bluetoothServices = CBMutableService(type: appUUIDKey, primary: true)
    }
    
    // Set up services and characteristics on your local peripheral
    func configureUtilityForIdentity(identity:PerformerIdentity!) {
        myIdentity = identity
        var characteristicsArray:NSMutableArray = []
        
        // Build the NAME characteristic
        if (identity.name != nil) {
            nameCharacteristic =
                CBMutableCharacteristic(type: performerNameCharacteristicUUID,
                    properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                    value: myIdentity?.name?.dataUsingEncoding(NSUTF8StringEncoding,
                        allowLossyConversion: false),
                    permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(nameCharacteristic!)
        }
        
        // Build the BIOGRAPHY characteristic
        if (identity.bioText != nil) {
            biographyCharacteristic = CBMutableCharacteristic(type: performerBiographyCharacteristicUUID,
                properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                value: myIdentity?.bioText?.dataUsingEncoding(NSUTF8StringEncoding,
                    allowLossyConversion: false),
                permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(biographyCharacteristic!)
        }
        
        // Build the IMAGE characteristic
        if (identity.image != nil) {
            var imageData:NSData = UIImageJPEGRepresentation(identity.image, 0.0)
            chosenImageCharacteristic = CBMutableCharacteristic(type: performerImageCharacteristicUUID,
                properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                value: imageData,
                permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(chosenImageCharacteristic!)
        }
        
        // Build the FACEBOOK characteristic
        if (identity.facebookLink != nil) {
            facebookCharacteristic = CBMutableCharacteristic(type: performerFacebookCharacteristicUUID,
                properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                value: identity.facebookLink?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false),
                permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(facebookCharacteristic!)
        }
        
        // Build the YOUTUBE characteristic
        if (identity.youtubeLink != nil) {
            youtubeCharacteristic = CBMutableCharacteristic(type: performerYoutubeCharacteristicUUID,
                properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                value: identity.youtubeLink?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(youtubeCharacteristic!)
        }
        
        // Build the miscellaneous WEBSITE characteristic
        if (identity.miscWebsite != nil) {
            miscWebsiteCharacteristic = CBMutableCharacteristic(type: performerMiscWebsiteCharacteristicUUID,
                properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast),
                value: identity.miscWebsite?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), permissions: CBAttributePermissions.Readable)
            
            characteristicsArray.addObject(miscWebsiteCharacteristic!)
        }
        
        // Add all the existing characteristics to our CBMutableService object
        bluetoothServices?.characteristics = characteristicsArray
        
        publishServices(bluetoothServices)
    }
    
    // Publish your services and characteristics to your device’s local database Advertise your services
    func publishServices(newService:CBMutableService!) {
        self.peripheralManager?.addService(newService)
    }
    
    // Mark: - CBPeripheralManagerDelegate Methods
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        println(peripheral.state)
    }
    
    func peripheralManager(peripheral: CBPeripheralManager!, didAddService service: CBService!, error: NSError!) {
        if (error != nil) {
            println("PerformerUtility.publishServices() returned error: \(error.localizedDescription)")
            println("Providing the reason for failure: \(error.localizedFailureReason)")
        }
        else {
            peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey : service.UUID])
        }
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!,
        error: NSError!) {
            if (error != nil) {
                println("peripheralManagerDidStartAdvertising encountered an error.")
                println(error.localizedDescription)
                println(error.localizedFailureReason)
            }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager!,
        central: CBCentral!,
        didSubscribeToCharacteristic characteristic: CBCharacteristic!) {
            println("A new CBCentral has subscribed to this device's CBServices")
            println(central.description)
    }
    
    func peripheralManager(peripheral: CBPeripheralManager!,
        central: CBCentral!,
        didUnsubscribeFromCharacteristic characteristic: CBCharacteristic!) {
            println("\(central.description) has unsubbed from this device's CBServices")
    }
    
    func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager!) {
        println("Updating subscribed devices")
    }
}


class SpectatorUtility: NSObject, CBCentralManagerDelegate {
    
    var centralManager:CBCentralManager?
    var discoveredPerformers:[CBPeripheral]?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        discoveredPerformers = [CBPeripheral]()
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println(central.state)
    }
    
    func centralManager(central: CBCentralManager!,
        didConnectPeripheral peripheral: CBPeripheral!) {

    }
}