//
//  GameScene.swift
//  PINGMS
//
//  Created by Jose Gutierrez on 7/25/17.
//  Copyright © 2017 JoseMake. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameState {
    case title, ready, playing, gameOver
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var state: GameState = .title
    
    
    var counterTest: Int = 0
    
    
    var pingBall: SKSpriteNode!
    
    var pingBallOuter: SKSpriteNode!
    
    var pingWalls: SKReferenceNode!
    
    var spawnTimer: CFTimeInterval = 0
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
    let scrollSpeed: CGFloat = 125
    
    var nullPoint: SKNode!
    
    var rightTouch: SKSpriteNode!
    
    var leftTouch: SKSpriteNode!
    
    var deathLabel: SKLabelNode!
    
    var restartLabel: SKLabelNode!
    
    var restartButton: MSButtonNode!
    
    var up = true
    
//    var leftPressed = false
//    
//    var rightPressed = false
    
    var timesDouble = 200.0 {
//        didSet will act as a function if the variable is changed
        didSet{
            if timesDouble < 25.0 {
                timesDouble = 25.0
            }
            
            if timesDouble > 200.0 {
                timesDouble = 200.0
            }
        }
    }
    
    var timesEase = Bool()
    
    var counter: Double = 0.0
    
    var jump: SKSpriteNode!
    
    var jumpAnimate = Bool()
    
    var invincibility: Bool = false
    
    var bounceStart = SKAction.scale(by: 10, duration: 0.7)
    
    var bounceEnd = SKAction.scale(by: 0.10, duration: 1.0)
    
    var bounceTimer: CFTimeInterval = 0
    
    var bounceBool = Bool()
    
    var points = 0
    
    var scoreLabel: SKLabelNode!
    
    var touchCounter = 0
    
    var startWallUpdate: Bool = true
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        pingBall = self.childNode(withName: "pingBall") as! SKSpriteNode
        
        pingBallOuter = pingBall.childNode(withName: "pingBallOuter") as! SKSpriteNode
        
        pingWalls = self.childNode(withName: "pingWalls") as! SKReferenceNode
        
        nullPoint = self.childNode(withName: "nullPoint")
        
        rightTouch = self.childNode(withName: "rightTouch") as! SKSpriteNode
        
        leftTouch = self.childNode(withName: "leftTouch") as! SKSpriteNode
        
        deathLabel = self.childNode(withName: "deathLabel") as! SKLabelNode
        
        restartLabel = self.childNode(withName: "restartLabel") as! SKLabelNode
        
        restartButton = self.childNode(withName: "//restartButton") as! MSButtonNode
        
        jump = self.childNode(withName: "JUMP") as! SKSpriteNode
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        
        
        self.state = .ready
        //        restartButton.selectedHandler = {
        //            /* Start game */
        //            self.state = .ready
        //        }
        
        restartButton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Variable for loading Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView?.presentScene(scene)
            
            /* Hide restart button */
            self.restartButton.state = .MSButtonNodeStateHidden
        }
        
        self.restartLabel.isHidden = true
        
        self.deathLabel.isHidden = true
        
        physicsWorld.contactDelegate = self
        
    }
    
    func gameOver() {
        /* Game over! */
        
        if invincibility == true{return}
        
        state = .gameOver
        
        self.restartLabel.isHidden = false
        
        self.deathLabel.isHidden = false
        
        /* Change play button selection handler */
        //            restartButton.selectedHandler = {
        //
        //            /* Grab reference to the SpriteKit view */
        //            let skView = self.view as SKView!
        //
        //            /* Load Game scene */
        //            guard let scene = GameScene(fileNamed:"GameScene") as GameScene! else {
        //                return
        //            }
        
        /* Ensure correct aspect mode */
        //            scene.scaleMode = .aspectFill
        //
        //            /* Restart GameScene */
        //            skView?.presentScene(scene)
        
    }
    
    func detectInsideWall() {
        if pingBall.position == self.nullPoint.position{
            print("we touched")
            gameOver()
        }
    }
    
    
    func updateObstacles() {
        /* Update Obstacles */
        
//        position movement
        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -26 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                pingWalls.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newPingWalls = pingWalls.copy() as! SKNode
            nullPoint.addChild(newPingWalls)
//            Shows when a new wall is created
            print("im a new brick boii" )
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newPingWalls.position = self.convert(randomPosition, to: nullPoint)
            
            counterTest += 1
            print(counterTest)
            
            if counterTest == 3 {
            startWallUpdate = false
            }
            
            // Reset spawn timer
            spawnTimer = 0
        }
        
    }
    
    func updateObstacles2() {
        /* Update Obstacles */
        
        //        position movement
        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -26 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                pingWalls.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newPingWalls = pingWalls.copy() as! SKNode
            nullPoint.addChild(newPingWalls)
            //            Shows when a new wall is created
            print("im a new brick boii")
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newPingWalls.position = self.convert(randomPosition, to: nullPoint)
            
            counterTest += 1
            print(counterTest)
            
            if counterTest == 3 {
                startWallUpdate = false
            }
            
            // Reset spawn timer
            spawnTimer = 0
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* Game not ready to play */
        if state == .gameOver || state == .title { return }
        /* Game begins on first touch */
        if state == .ready {
            state = .playing
        }
        
        //        up = true
        
        for touch in touches{
            let touchLocation = touch.location(in: self)
            let touchedNode = atPoint(touchLocation)
            
            if touchedNode.name == "rightTouch" {
                print("look at me")
                up = !up
//                rightPressed = true
            }
            
            
            if touchedNode.name == "leftTouch" {
                print("look at me")
                timesEase = true
//                leftPressed = true
            }
            
            if touchedNode.name == "JUMP"{
                jump.isHidden = true
//                touchCounter += 1
                
                if touches.count == 1{
//                    bounceTimer = 0.0
                    bounceBool = true
                    print(touches.count)
                    print("DOUBLE TOUCH!!!! YEAAAAHHHHHHH")
                    invincibility = true
                    
                    let bounceSequence1 = SKAction.sequence([bounceStart])
                    let bounceSequence2 = SKAction.sequence([bounceEnd])
                    self.pingBall.run(bounceSequence1){
                    
                    if self.touchCounter == 2{
                        self.invincibility = false
                        self.gameOver()
                        return
                    }
                }
                
                    self.pingBall.run(bounceSequence2){
                        
                        self.invincibility = false
                        self.jump.isHidden = false
                        return
//                       self.detectInsideWall()
                        }
                   
//                    if invincibility == true {
//                        if bounceTimer >= 3 {
//                            print(bounceTimer)
//                            invincibility = !invincibility
//                        }
//                    }
                    
                    
                    
//                    if bounceBool == true{
//                        invincibility = false
//                    }
                    
//                    if bounceTimer == 1.0{
//                    invincibility = false
//                    }
                   
                    
                    return
                    
                }
            }
        }
        //
        //            if rightTouch.contains(touchLocation){
        //                if up == true{
        //                    up = false
        //                } else if up == false{
        //                up = true
        //                    }
        //                }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            let touchedNode = atPoint(touchLocation)
            if touchedNode.name == "leftTouch"{
            timesEase = false
            }
        }
    }



func didBegin(_ contact: SKPhysicsContact) {
    
                /* Get references to bodies involved in collision */
                let contactA = contact.bodyA
                let contactB = contact.bodyB
    
                /* Get references to the physics body parent nodes */
                let nodeA = contactA.node!
                let nodeB = contactB.node!
    
    if nodeA.physicsBody?.categoryBitMask == 2 && nodeB.physicsBody?.categoryBitMask == 1 ||
       nodeA.physicsBody?.categoryBitMask == 1 && nodeB.physicsBody?.categoryBitMask == 2{
        if self.invincibility {return}
        
        if self.invincibility == false {
        gameOver()
        }
//        you can also use this for decrementing healthzz
    }
    
    if nodeA.physicsBody?.categoryBitMask == 4 && nodeB.physicsBody?.categoryBitMask == 1 ||
        nodeA.physicsBody?.categoryBitMask == 1 && nodeB.physicsBody?.categoryBitMask == 4{
        points += 1
        scoreLabel.text = String(points)
//        jump.isUserInteractionEnabled = true
        return
    }
    
    gameOver()
    restartButton.state = .MSButtonNodeStateActive
    
}
    
    func didEnd(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        if nodeA.physicsBody?.categoryBitMask == 2 && nodeB.physicsBody?.categoryBitMask == 1 ||
            nodeA.physicsBody?.categoryBitMask == 1 && nodeB.physicsBody?.categoryBitMask == 2{
            if self.invincibility {return}
            
            if self.invincibility == false {
                gameOver()
            }
        }
    }
 

override func update(_ currentTime: TimeInterval) {
    
//    print(invincibility)
//    print(jump.isUserInteractionEnabled)
    
    if pingBall.position.y > self.frame.height || pingBall.position.y < 0{
        gameOver()
    }
    
    if timesEase{
        timesDouble -= 21
    }else{
        timesDouble += 21
    }
    
    if self.state == .gameOver {return}
    if up == true{
        pingBall.position.y += CGFloat(fixedDelta * timesDouble)
    }else if up != true{
        pingBall.position.y -= CGFloat(fixedDelta * timesDouble)
    }
    //
    // Called before each frame is rendered
    spawnTimer += fixedDelta
    if bounceBool == true {bounceTimer += fixedDelta}
    //        if spawnTimer >= 10{
    //            gameOver()
    //        }
    
    if startWallUpdate{
    updateObstacles()
    }else{
        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        updateObstacles2()
        
//        updateObstacles2()
//         for obstacle in nullPoint.children as! [SKReferenceNode] {
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
//        let nullPosition = nullPoint.convert(obstacle.position, to: self)
//        if nullPosition.x <= 200 {
//            // 26 is one half the width of an obstacle
//            
//            /* Remove obstacle node from obstacle layer */
//            pingWalls.removeFromParent()
//            print("im out my guy f dis shiiii")
//            print(nullPosition.x)
//        }
        
        
        return
    }
    
    
}


}
