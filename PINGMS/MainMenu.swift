//
//  MainMenu.swift
//  PINGMS
//
//  Created by Jose Gutierrez on 8/17/17.
//  Copyright © 2017 JoseMake. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class MainMenu: SKScene{
    
    
    let pingMainScreen = SKVideoNode(fileNamed: "PINGMainMenu.mov")
    
    let mainSecretScreen = SKVideoNode(fileNamed: "PINGMainMenu_Sc.mov")
    
    var randomLoad: Int!
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
    var videoCounter: CFTimeInterval = 0
    
    var videoFadeOut = SKAction.fadeOut(withDuration: 2)
    
    var secretFade = false
    
    var mainFade = false
    
    var loadButton: MSButtonNode!
    
    var optionsButton: MSButtonNode!
    
    var startButton: MSButtonNode!
    
    var backButton: MSButtonNode!
    
    var leftScreen: SKSpriteNode!
    
    var rightScreen: SKSpriteNode!
    
    var shiftToCenter = SKAction.moveTo(x: 284, duration: 1)
    
    var shiftToLeft = SKAction.moveTo(x: 0, duration: 1)
    
    var shiftToRight = SKAction.moveTo(x: 568, duration: 1)
    
    var blackNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        loadButton = self.childNode(withName: "loadButton") as! MSButtonNode
        
        optionsButton = self.childNode(withName: "optionsButton") as! MSButtonNode
        
        startButton = self.childNode(withName: "startButton") as! MSButtonNode
        
        backButton = self.childNode(withName: "//backButton") as! MSButtonNode
        
        leftScreen = self.childNode(withName: "leftScreen") as! SKSpriteNode
        
        rightScreen = self.childNode(withName: "rightScreen") as! SKSpriteNode
        
        blackNode = self.childNode(withName: "blackNode") as! SKSpriteNode
        
        startButton.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Variable for loading Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFit
            
            /* Restart game scene */
            skView?.presentScene(scene)

        }
     
        optionsButton.selectedHandler = {
           
            self.rightScreen.run(self.shiftToCenter)
            self.leftScreen.run(self.shiftToCenter)
            
            
        }
       
        backButton.selectedHandler = {
            
            self.rightScreen.run(self.shiftToRight)
            self.leftScreen.run(self.shiftToLeft)
            
            
        }
        
        randomLoad = Int(arc4random_uniform(2))
        
//        var screenFadeOut = mainSecretScreen.alpha{
//            didSet{
//                if screenFadeOut < 0{
//                    screenFadeOut = 0
//                }
//            }
//        }
        
        
        
        
    }
    
//    func fadeBoolCheck() {
    
        
        
//        ANIMATION CODE
        
        
//        if secretFade == true{
//         mainSecretScreen.run(videoFadeOut)
//        }
//        if mainFade == true{
//            pingMainScreen.run(videoFadeOut)
//        }
//    }
    
    
    func mainScreenVideo() {
        pingMainScreen.position = CGPoint(x: 284, y: 160)
        pingMainScreen.zPosition = 2000
        pingMainScreen.size.height = 320 //self.frame.height
        pingMainScreen.size.width = 568//self.frame.width
        pingMainScreen.name = "Main Video"
        self.addChild(pingMainScreen)
        pingMainScreen.play()
        print("main screen is playing")
        randomLoad = 5
        //self.blackNode.removeFromParent()
    }
    
    
    func secretScreenVideo() {
        mainSecretScreen.position = CGPoint(x: 284, y: 160)
        mainSecretScreen.zPosition = 2000
        mainSecretScreen.size.height = 320 //self.frame.height
        mainSecretScreen.size.width = 568//self.frame.width
        mainSecretScreen.name = "Secret Video"
        self.addChild(mainSecretScreen)
        mainSecretScreen.play()
        print("you've unlocked a secret!")
        randomLoad = 5
        //self.blackNode.removeFromParent()
    }
    
//    thank you thinkPad
    override func update(_ currentTime: TimeInterval){
        videoCounter += fixedDelta
        
        if randomLoad == 0 {
            self.secretScreenVideo()
//            self.blackNode.removeFromParent()
            
        } else if randomLoad == 1{
            self.mainScreenVideo()
//            self.blackNode.removeFromParent()
        }
        
        if let node = self.childNode(withName: "Main Video") as! SKVideoNode?{
            if videoCounter >= 2.5{
                node.removeFromParent()
                self.blackNode.removeFromParent()
            }
        }
        
        if let node = self.childNode(withName: "Secret Video") as! SKVideoNode?{
            if videoCounter >= 2.5{
                node.removeFromParent()
                self.blackNode.removeFromParent()
            }
        }
//
//        if videoCounter >= 4 && load == 0{
//            secretFade = true
//        }
//        
//        if videoCounter >= 4{
//            mainFade = true
//        }
        
    
    }
}
