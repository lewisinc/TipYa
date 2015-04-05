//
//  Bluetooth.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import Foundation
import CoreBluetooth

// An Application level UUID - "Is this device running our app?"
var appUUIDKey = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD540")

// UUIDs for a performer - "Are you a performer? - Let's get your services, etc."
var performerIdentityUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD544")
var performerServicesUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD545")
var performerNameCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD546")
var performerBiographyCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD547")
var performerImageCharacteristicUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD548")

// UUIDs for a spectator - "You don't need to interact with a spectator."
var spectatorUUIDKey = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD550")


// First list all our CBUUIDs

class PerformerUtility: NSObject, CBPeripheralManagerDelegate {
    
    var peripheralManager:CBPeripheralManager?
    var myIdentity:PerformerIdentity?
    var bluetoothServices:CBMutableService?                 // All available services
    var nameCharacteristic:CBMutableCharacteristic?         // Performers name
    var biographyCharacteristic:CBMutableCharacteristic?    // Short bio
    var chosenImageCharacteristic:CBMutableCharacteristic?  // Small photo < 10mb
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
        // Build the name characteristic
        nameCharacteristic = CBMutableCharacteristic(type: performerNameCharacteristicUUID, properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast), value: myIdentity?.name?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), permissions: CBAttributePermissions.Readable)
        
        // Build the biography characteristic
        biographyCharacteristic = CBMutableCharacteristic(type: performerBiographyCharacteristicUUID, properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast), value: myIdentity?.bioText?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), permissions: CBAttributePermissions.Readable)
        
        // Build the image characteristic
        
        
        chosenImageCharacteristic = CBMutableCharacteristic(type: performerImageCharacteristicUUID, properties: (CBCharacteristicProperties.Read | CBCharacteristicProperties.Broadcast), value: nil, permissions: CBAttributePermissions.Readable)
    }
    
    // Publish your services and characteristics to your device’s local database Advertise your services
    
    // Respond to read and write requests from a connected central
    // Send updated characteristic values to subscribed centrals
    
    
    // Mark: - CBPeripheralManagerDelegate Methods
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        println(peripheral.state)
    }
}


class SpectatorUtility: NSObject, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println(central.state)
    }
}