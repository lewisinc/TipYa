//
//  Bluetooth.swift
//  TipYa
//
//  Created by David Lewis on 4/4/15.
//  Copyright (c) 2015 LAHacksDLNSJO. All rights reserved.
//

import Foundation
import CoreBluetooth

// Has performance data to share
// This class is a CBPeripheralManager, managing itself essentially.
// This class also performs callbacks on behalf of a CBCentralManager as its delegate.
class TJBluetoothPerformer: CBPeripheralManager, CBCentralManagerDelegate {
    
    var discoveredPerformers:[PerformerIdentity]?
    var discoveredPeripherals:[CBPeripheral]?
    
    // An Application level UUID - "Is this device running our app?"
    var appUUIDKey = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD543")
    
    // UUIDs for a performer - "Are you a performer? - Let's get your services, etc."
    var performerIdentityUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD545")
    var performerServicesUUID = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD546")
    var performerNameCharacteristicUUID
    var performerBiographyCharacteristicUUID
    var performerImageCharacteristicUUID
    
    // UUIDs for a spectator - "You don't need to interact with a spectator."
    var spectatorUUIDKey = CBUUID(string: "9BC1F0DC-F4CB-4159-BD38-7B75CD0CD547")
    
// BELOW: Delegate Methods and their implementations
    
    /* Discovered a nearby peripheral device
    1. Compare CBUUIDs
    2. Other stuff
    ...
    ?. If all is good, proceed to connect
    */
    func centralManager(central: CBCentralManager!,
        didDiscoverPeripheral peripheral: CBPeripheral!,
        advertisementData: [NSObject : AnyObject]!,
        RSSI: NSNumber!) {
            
            
    }
    /* Successfully connected to a peripheral
    - needs description
    */
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
        
    }
    /* Disconnected a peripheral
    - needs description
    */
    func centralManager(central: CBCentralManager!,
        didDisconnectPeripheral peripheral: CBPeripheral!,
        error: NSError!) {
            
    }
    /* Failed to connect to peripheral
    - needs description
    */
    func centralManager(central: CBCentralManager!,
        didFailToConnectPeripheral peripheral: CBPeripheral!,
        error: NSError!) {
            
    }
    /* Invoked when the CentralManager retrieves a list of CONNECTED peripherals
    - needs description
    */
    func centralManager(central: CBCentralManager!,
        didRetrieveConnectedPeripherals peripherals: [AnyObject]!) {
            
    }
    /* Invoked when the CentralManager retrieves a list of KNOWN peripherals
    - needs description
    */
    func centralManager(central: CBCentralManager!,
        didRetrievePeripherals peripherals: [AnyObject]!) {
            
    }
    /* Invoked when about to restore CentralManager to previous state
    - needs description
    */
    func centralManager(central: CBCentralManager!,
        willRestoreState dict: [NSObject : AnyObject]!) {
            
    }
    /* Invoked when the central manager’s state is updated. (required)
    - needs description
    */
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
    }
}

// Requests all nearby peripherals performance data
// This class is a CBCentralManager and performs callback actions on behalf of a CBPeripheral object as its delegate.
class TJBluetoothSpectator: CBCentralManager, CBPeripheralDelegate {
    
    
    
// BELOW: Delegate Methods and their implementations

    var discoveredPeripherals:NSArray?
    
    /* Invoked when you discover the peripheral’s available services
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didDiscoverServices error: NSError!) {
            
    }
    /* Invoked when you discover included services within a specified service
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didDiscoverIncludedServicesForService service: CBService!,
        error: NSError!) {
            
    }
    /* Invoked when you discover the characteristics of a specified service
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didDiscoverCharacteristicsForService service: CBService!,
        error: NSError!) {
            
    }
    /* Invoked when you discover the descriptors of a specified characteristic
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic!,
        error: NSError!) {
            
    }
    /* Invoked when you retrieve a specified characteristic’s value, or when the peripheral device notifies your app that the characteristic’s value has changed
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didUpdateValueForCharacteristic characteristic: CBCharacteristic!,
        error: NSError!) {
            
    }
    /* Invoked when you retrieve a specified characteristic descriptor's value
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didUpdateValueForDescriptor descriptor: CBDescriptor!,
        error: NSError!) {
            
    }
    /* Invoked when you write data to a characteristic’s value
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didWriteValueForCharacteristic characteristic: CBCharacteristic!,
        error: NSError!) {
            
    }
    /* Invoked when you write data to a characteristic descriptor’s value
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didWriteValueForDescriptor descriptor: CBDescriptor!,
        error: NSError!) {
            
    }
    /* Invoked when the peripheral receives a request to start or stop providing notifications for a specified characteristic’s value
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!,
        error: NSError!) {
            
    }
    /* Invoked when a peripheral’s name changes
    - needs description
    */
    func peripheralDidUpdateName(peripheral: CBPeripheral!) {
        
    }
    /* Invoked when a peripheral’s services have changed
    - needs description
    */
    func peripheral(peripheral: CBPeripheral!,
        didModifyServices invalidatedServices: [AnyObject]!) {
            
    }
}