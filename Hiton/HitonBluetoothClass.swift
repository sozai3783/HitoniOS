//
//  HitonBluetoothClass.swift
//  BlueTooth-Test
//
//  Created by yao on 16/03/2016.
//  Copyright © 2016 yao. All rights reserved.
//

import UIKit


class HitonBluetoothClass: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    class var sharedInstance: HitonBluetoothClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: HitonBluetoothClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = HitonBluetoothClass()
        }
        return Singleton.staticInstance!
    }
    
    private var myCentralManager: CBCentralManager!
    private var myPeripheral: CBPeripheral!
    private var writeCharacteristic: CBCharacteristic!
    
    private var scanTimer: NSTimer!
    private var readTimer: NSTimer!
    
    var connectSuccess: (() -> Void)?
    var connectFail: (() -> Void)?
    var disconnect: (() -> Void)?
    var scaning: (() -> Void)?
    
    var hit: ((_ str: String) -> Void)?
    
    var isReady: (() -> Void)?
    
    var isConnected = false
    
    var ReadUnitCode = false
    
    override init() {
        super.init()
        myCentralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    
    func checkingBluetooth(){
        if isConnected == false {
            if scanTimer != nil {
                scanTimer.invalidate()
            }
            scanTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HitonBluetoothClass.scan), userInfo: nil, repeats: true)

        }else {
        
        }
    }
    
    func startScan(){
    }
    
    func resetValue(){
        let data = tools.stringToByte("20")
        myPeripheral.writeValue(data, forCharacteristic: writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager){
        switch central.state{
        case CBCentralManagerState.Unauthorized:
            print("The app is not authorized to use Bluetooth low energy.")
            isConnected = false
            if let callback = self.disconnect{
                callback()
            }
            self.checkingBluetooth()
        case CBCentralManagerState.PoweredOff:
            print("Bluetooth is currently powered off.")
            isConnected = false
            if let callback = self.disconnect{
                callback()
            }
            self.checkingBluetooth()
        case CBCentralManagerState.PoweredOn:
            //scanTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HitonBluetoothClass.scan), userInfo: nil, repeats: true)
            self.checkingBluetooth()
            
        default:break
        }
    }
    
    func scan(){
        myCentralManager.scanForPeripheralsWithServices(nil , options: nil)
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //print("Scaning: central:\(central) -- peripheral:\(peripheral) -- desc = \(peripheral.identifier.description)")
        //if peripheral.identifier.UUIDString == "9946B0DF-1902-7179-E379-767EC7EEF847"{
        //print(peripheral.name!)
        isConnected = false
        let name = peripheral.name?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if name == "Hiton" {
            print("connecting...")
            if scanTimer != nil {
                scanTimer.invalidate()
            }
            myPeripheral = peripheral
            myCentralManager!.connectPeripheral(myPeripheral, options: nil)
        }else{
        }
        
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("CenCentalManagerDelegate didConnectPeripheral")
        if let callback = self.connectSuccess{
            callback()
        }
        myCentralManager.stopScan()
        isConnected = true
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CenCentalManagerDelegate didFailToConnectPeripheral")
        if let callback = self.connectFail{
            callback()
        }
        
        scanTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HitonBluetoothClass.scan), userInfo: nil, repeats: true)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CenCentalManagerDelegate didDisconnectPeripheral")
        if let callback = self.disconnect{
            callback()
        }
        isConnected = false
        if readTimer != nil {
            readTimer.invalidate()
        }
        scanTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HitonBluetoothClass.scan), userInfo: nil, repeats: true)
    }
    
    func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        print("willRestoreState")
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for s in peripheral.services! {
            peripheral.discoverCharacteristics(nil, forService: s)
            
        }
    }
    
    
    
    func readValue(){
        if readTimer != nil {
            readTimer.invalidate()
        }
        readTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(HitonBluetoothClass.read), userInfo: nil, repeats: true)
    }
    
    func read(){
        if isConnected == true {
            ReadUnitCode = false
            let data = tools.stringToByte("12")
            myPeripheral.writeValue(data, forCharacteristic: writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
            
        }
    }
    
    func readUnitCode(){
        ReadUnitCode = true
        let data = tools.stringToByte("14")
        myPeripheral.writeValue(data, forCharacteristic: writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
    }

    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if(error != nil){
            print("Error Reading characteristic value: \(error!.localizedDescription)")
        }else{
            if ReadUnitCode == true {
                let tempStr = (characteristic.value?.description)!.stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "")
                print("Unit Code = \(tempStr)")
                //if tempStr == "14112233 44556677 8814"{
                    ReadUnitCode = false
                    resetValue()
                    readValue()
                //}else{
                //    myCentralManager.cancelPeripheralConnection(myPeripheral)
                //}
            }else{
                let tempStr = (characteristic.value?.description)!.stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "")
                if tempStr == "00"{
                    
                }else{
                    if let callback = self.hit{
                        callback(str: tempStr)
                    }
                    resetValue()
                }
            }
        }
    }
    
    
    //用于检测中心向外设写数据是否成功
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if(error != nil){
            print("发送数据失败!error信息:\(error)")
        }else{
            //peripheral.readValueForCharacteristic(readCharacteristic)
        }
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        for c in service.characteristics! {
            //print("c = \(c)")
            switch c.UUID.description {
            case "1001":
                writeCharacteristic = c
                peripheral.setNotifyValue(true, forCharacteristic: c)
                self.readUnitCode()
                break
            case "1002":
                peripheral.setNotifyValue(true, forCharacteristic: c)
                break
            case "FFF0":
                break
            case "System ID":
                break
            case "Model Number String":
                break
            case "Serial Number String":
                break
            case "Firmware Revision String":
                break
            case "Hardware Revision String":
                break
            case "Software Revision String":
                break
            case "Manufacturer Name String":
                break
            case "IEEE Regulatory Certification":
                break
            case "PnP ID":
                break
            default:
                break
            }
        }
        if let callback = self.isReady{
            callback()
        }
    }
    


    
    
}
