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
    var scenType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("【Scene】" + self.scenType! + " In GameViewController ViewDidLoad")
        let skView = view as! SKView
//        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("receivedValue:"), name: BLEServiceReceiveNotification, object: nil)
        
    }
    
    func receivedValue(notification: NSNotification){
        let userInfo = notification.userInfo as! [String: String]
        let values:[String]! = userInfo["value"]?.componentsSeparatedByString("\t")
        
        if values.count != 3 {
            return
        }
        
        dispatch_async(dispatch_get_main_queue(), {
//            self.label1.text = values[0]
//            self.label2.text = values[1]
//            self.label3.text = values[2]
//            self.
            let spriteView:SKView = self.view as! SKView
            let speed = 10 * NSNumberFormatter().numberFromString(values[0])!.doubleValue
            let pose = NSNumberFormatter().numberFromString(values[1])!.integerValue
            let stability = NSNumberFormatter().numberFromString(values[2])!.boolValue
            
            if self.scenType == kSceneTypeShuiZhong{
                let scene = spriteView.scene as! ShuiZhongScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeSenlin{
                let scene = spriteView.scene as! SenlinScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeShanGu{
                let scene = spriteView.scene as! ShanGuScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeHaibian{
                let scene = spriteView.scene as! HaibianScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }

        });
    }
    
    override func viewWillAppear(animated: Bool) {
        let skView = view as! SKView
        var spriteView : SKView = self.view as! SKView
        if scenType == kSceneTypeShuiZhong{
            var scene: ShuiZhongScene = ShuiZhongScene(size: self.view.frame.size)
            spriteView.presentScene(scene)
        }else if scenType == kSceneTypeSenlin{
            var scene: SenlinScene = SenlinScene(size: self.view.frame.size)
            spriteView.presentScene(scene)
        }else if scenType == kSceneTypeShanGu{
            var scene: ShanGuScene = ShanGuScene(size: self.view.frame.size)
            spriteView.presentScene(scene)
        }else if scenType == kSceneTypeHaibian{
            var scene: HaibianScene = HaibianScene(size: self.view.frame.size)
            spriteView.presentScene(scene)
        }

//        spriteView.scene
    }

}
