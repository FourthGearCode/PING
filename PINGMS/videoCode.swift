//
//  videoCode.swift
//  PINGMS
//
//  Created by Jose Gutierrez on 8/14/17.
//  Copyright © 2017 JoseMake. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class personalVideo: SKScene {
    let needleIntro = SKVideoNode(fileNamed: "updatedNeedleInt.mov")
    
    override func didMove(to view: SKView) {
        needleVideo()
        
    }
    
    func needleVideo() {
        needleIntro.position = CGPoint(x: 0, y: 0)
        needleIntro.zPosition = 200
        needleIntro.size.height = 1000 //self.frame.height
        needleIntro.size.width = 1000//self.frame.width
        addChild(needleIntro)
        needleIntro.play()
        print("kkkkkkkkk")
    }
    
    
}
