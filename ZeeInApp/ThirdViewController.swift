//
//  ThirdViewController.swift
//  ZeeInApp
//
//  Created by WangJZ on 15/4/6.
//  Copyright (c) 2015年 WangJZ. All rights reserved.
//

import UIKit
import SpriteKit


class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsFPS = true
    }
    
    override func viewWillAppear(animated: Bool) {
        var helloScene:HelloScene = HelloScene(size: CGSizeMake(768, 1024))
        var spriteView:SKView = self.view as SKView
        spriteView.presentScene(helloScene)
    }
    

}

