//
//  FirstViewController.swift
//  ZeeInApp
//
//  Created by WangJZ on 15/4/4.
//  Copyright (c) 2015年 WangJZ. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var imgBluetoothStatus: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func connectBlueTooth() {
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("connectionChanged:"), name: BLEServiceChangedStatusNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("receivedValue:"), name: BLEServiceReceiveNotification, object: nil)
        // Start the Bluetooth discovery process
        btDiscoverySharedInstance
    }
    
    func receivedValue(notification: NSNotification){
        let userInfo = notification.userInfo as [String: String]
        let values:[String]! = userInfo["value"]?.componentsSeparatedByString("\t")
        
        dispatch_async(dispatch_get_main_queue(), {
            self.label1.text = values[0]
            self.label2.text = values[1]
            self.label3.text = values[2]
        });
    }
    
    
    func connectionChanged(notification: NSNotification) {
        // Connection status changed. Indicate on GUI.
        let userInfo = notification.userInfo as [String: Bool]
        dispatch_async(dispatch_get_main_queue(), {
            //Set image based on connection status
            if let isConnected: Bool = userInfo["isConnected"] {
                if isConnected {
                    self.imgBluetoothStatus.image = UIImage(named: "Bluetooth_Connected")
                } else {
                    self.imgBluetoothStatus.image = UIImage(named: "Bluetooth_Disconnected")
                }
            }
        });
    }
    
    @IBAction func startPractice() {
        //开始练习，如果蓝牙没有开启，请开启
        println("【按钮】开始练习")
        connectBlueTooth()
    }
    
    @IBAction func jump() {
        //跳转按钮
        println("【按钮】跳转统计")
        btDiscoverySharedInstance.bleService?.reset()
        self.tabBarController?.selectedIndex = 1
    }
}

