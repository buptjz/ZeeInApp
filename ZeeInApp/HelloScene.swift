//
//  HelloScene.swift
//  ZeeInApp
//
//  Created by WangJZ on 15/4/6.
//  Copyright (c) 2015年 WangJZ. All rights reserved.
//

import SpriteKit

class HelloScene:SKScene {
    var contentCreated:Bool = false
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            createSceneContents()
            contentCreated = true
        }
    }

    func createSceneContents() {
//        backgroundColor = SKColor.blueColor()
        scaleMode = SKSceneScaleMode.AspectFit
        addChild(newHelloNode())
        
        let sparkEmmiter = SKEmitterNode(fileNamed: "MyParticle.sks")
        sparkEmmiter.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 200)
        sparkEmmiter.name = "sparkEmmitter"
        sparkEmmiter.zPosition = 1
        sparkEmmiter.targetNode = self
        sparkEmmiter.particleLifetime = 1
        self.addChild(sparkEmmiter)
    }
    
    func newHelloNode() -> SKLabelNode! {
        var helloNode:SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        helloNode.text = "Hello, World!"
        helloNode.fontSize = 42
        helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        helloNode.name = "helloNode"
        
        return helloNode
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var helloNode:SKNode! = childNodeWithName("helloNode")
        if helloNode != nil {
            helloNode.name = nil
            
            var moveUp:SKAction = SKAction.moveByX(0, y: 100, duration: 0.5)
            var zoom:SKAction = SKAction.scaleTo(2, duration: 0.25)
            var pause:SKAction = SKAction.waitForDuration(0.5)
            var fadeAway = SKAction.fadeOutWithDuration(0.25)
            var remove = SKAction.removeFromParent()
            var moveSequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])
            helloNode.runAction(moveSequence)
        }
        
        
    }
}

