//
//  ViewController.swift
//  CoreBlueTooth1
//
//  Created by arshad on 4/28/22.
//

import CoreBluetooth
import UIKit

class ViewController: UIViewController {
    let centralManager = CBCentralManager()
    let pheripheralManager = CBPeripheralManager()
    let BLE_Heart_Rate_Service_CBUUID = CBUUID(string: "0x180D")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
}


extension ViewController : CBCentralManagerDelegate{
    
    // find the yours mobile Bluetoot is ON OR NOT
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            central.scanForPeripherals(withServices: [BLE_Heart_Rate_Service_CBUUID], options: nil)
        @unknown default:
            print("Unknow Error")
        }
    }
        
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral.name!)
       
        pheripheralManager.delegate = self
       
        //start to connect to pheriphral
        centralManager.connect(peripheral)
        //stop scanning
        centralManager.stopScan()
        
    }
}

extension ViewController: CBPeripheralDelegate, CBPeripheralManagerDelegate{
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }

}
