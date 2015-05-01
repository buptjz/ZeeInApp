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
    var mysk : SKView?
    override func viewDidLoad() {
        super.viewDidLoad()
        println("【Scene】" + self.scenType! + " In GameViewController ViewDidLoad")

        mysk = SKView(frame: self.view.frame)
        self.view.addSubview(mysk!)
        mysk!.showsNodeCount = true
        let button = UIButton(frame:CGRect(origin: CGPointMake(100.0, 110.0), size:CGSizeMake(150,50)))
        button.setTitle("OK", forState:UIControlState.Normal)
        button.addTarget(self, action:"buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        mysk!.addSubview(button)
        
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
//            let mysk:SKView = self.view as! SKView
            let speed = 10 * NSNumberFormatter().numberFromString(values[0])!.doubleValue
            let pose = NSNumberFormatter().numberFromString(values[1])!.integerValue
            let stability = NSNumberFormatter().numberFromString(values[2])!.boolValue
            
            if self.scenType == kSceneTypeShuiZhong{
                let scene = self.mysk!.scene as! ShuiZhongScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeSenlin{
                let scene = self.mysk!.scene as! SenlinScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeShanGu{
                let scene = self.mysk!.scene as! ShanGuScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }else if self.scenType == kSceneTypeHaibian{
                let scene = self.mysk!.scene as! HaibianScene
                scene.updateParticleEmitter(CGFloat(speed), pose: pose, stable:stability)
            }

        });
    }
    
    override func viewWillAppear(animated: Bool) {
        println("View will Appear")
        if scenType == kSceneTypeShuiZhong{
            self.mysk!.presentScene(ShuiZhongScene(size: self.view.frame.size))
        }else if scenType == kSceneTypeSenlin{
            self.mysk!.presentScene(SenlinScene(size: self.view.frame.size))
        }else if scenType == kSceneTypeShanGu{
            self.mysk!.presentScene(ShanGuScene(size: self.view.frame.size))
        }else if scenType == kSceneTypeHaibian{
//            var scene: HaibianScene =
            self.mysk!.presentScene(HaibianScene(size: self.view.frame.size))
        }
    }
    
    func buttonClick(sender: AnyObject){
        //fix sprite bugs
        mysk!.paused = true
        mysk!.scene?.removeFromParent()
        mysk!.removeFromSuperview()
//        mysk!.scene.chil
        for child in mysk!.scene!.children{
            let c = child as! SKNode
            c.removeAllActions()
            c.removeAllChildren()
        }
        mysk!.scene!.removeAllChildren()

    }
    
    @IBAction func finishBtnPress(sender: AnyObject) {
////        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
