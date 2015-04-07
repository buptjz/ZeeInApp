//
//  GameViewController.swift
//  ZeeInApp
//
//  Created by WangJZ on 15/4/7.
//  Copyright (c) 2015年 WangJZ. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as SKView
//        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("receivedValue:"), name: BLEServiceReceiveNotification, object: nil)
        
    }
    
    func receivedValue(notification: NSNotification){
        let userInfo = notification.userInfo as [String: String]
        let values:[String]! = userInfo["value"]?.componentsSeparatedByString("\t")
        
        if values.count != 3 {
            return
        }
        
        dispatch_async(dispatch_get_main_queue(), {
//            self.label1.text = values[0]
//            self.label2.text = values[1]
//            self.label3.text = values[2]
//            self.
            let spriteView:SKView = self.view as SKView
            let scene = spriteView.scene as HelloScene
            let speed = 10 * NSNumberFormatter().numberFromString(values[0])!.doubleValue
            scene.updateParticleEmitter(CGFloat(speed), alpha: 0.5)
        });
    }
    
    
    override func viewWillAppear(animated: Bool) {
//        var helloScene: HelloScene = HelloScene(size: CGSizeMake(768, 1024))
        let skView = view as SKView
        var helloScene: HelloScene = HelloScene(size: self.view.frame.size)
        
        var spriteView:SKView = self.view as SKView
        spriteView.presentScene(helloScene)
        spriteView.scene
    }

}
