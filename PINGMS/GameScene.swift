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
    
    var arrayNode: SKNode!
    
    var counterTest: Int = 0
    
    var blueCounter: Int = 0
    
    var yellowCounter: Int = 0
    
    
    var firstText: SKLabelNode!
    
    var pingBall: SKSpriteNode!
    
    var pingBallOuter: SKSpriteNode!
    
    var pingWalls: SKReferenceNode!
    
    var blueWalls: SKReferenceNode!
    
    var yellowWalls: SKReferenceNode!
    
    var slicer: SKReferenceNode!
    
    var spawnTimer: CFTimeInterval = 0
    
    var slicerTimer: CFTimeInterval = 0
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    
    var scrollSpeed: CGFloat = 150
    
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
    
    var delayTimer: CFTimeInterval = 0
    
    var startWallUpdate: Bool = true
    
    var secondEnemyStart: Bool = false
    
    var thirdEnemyStart: Bool = false
    
    var slicerActivation: Bool = false
    
    var halt = false
    
    var theLight: SKSpriteNode!
    
    var obsCounter = 0
    
    var obsRemoval = Bool()
    
    var blueSpawnBool = true
    
    var yellowSpawnBool = true
    
    var slicerStartBool = true
    
    var offset:Int = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
//        arrayNode = self.childNode(withName: "arrayNode") as! SKNode
        
        pingBall = self.childNode(withName: "pingBall") as! SKSpriteNode
        
        pingBallOuter = pingBall.childNode(withName: "pingBallOuter") as! SKSpriteNode
        
        pingWalls = self.childNode(withName: "pingWalls") as! SKReferenceNode
        
        blueWalls = self.childNode(withName: "blueWalls") as! SKReferenceNode
        
        yellowWalls = self.childNode(withName: "yellowWalls") as! SKReferenceNode
        
        firstText = self.childNode(withName: "//text1") as! SKLabelNode
        
        slicer = self.childNode(withName: "slicer") as! SKReferenceNode
        
        nullPoint = self.childNode(withName: "nullPoint")
        
        rightTouch = self.childNode(withName: "rightTouch") as! SKSpriteNode
        
        leftTouch = self.childNode(withName: "leftTouch") as! SKSpriteNode
        
        deathLabel = self.childNode(withName: "deathLabel") as! SKLabelNode
        
        restartLabel = self.childNode(withName: "restartLabel") as! SKLabelNode
        
        restartButton = self.childNode(withName: "//restartButton") as! MSButtonNode
        
        jump = self.childNode(withName: "JUMP") as! SKSpriteNode
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        
        theLight = self.childNode(withName: "theLight") as! SKSpriteNode
        
        let bottomPosition = CGPoint(x: 284, y: -100)
        
        slicer.position = bottomPosition
        
        
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

//        pingPath = childNode(withName: "pingPath") //as! GKGraph
        
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
//    var npcList = [SKSpriteNode]()
    
//    func boi() {
//        for childReference in arrayNode.children{
//            for childSKNode in childReference.children{
//                for child in childSKNode.children{
//                    npcList.append(child as! SKSpriteNode)
//                    
//                    let blue = npcList[2]
//                    if blue.position.x <= -12.5{
//                        blue.removeFromParent()
//                    }
//                    
//                    
//                }
//            }
//        }
//    }
//    Lisas confusing code
    
    func increaseSpeed() {
        
       
        
        if obsCounter == 0 && state != .gameOver {
            print("jump is running")
            firstText.run(SKAction(named: "speedUp")!){
                self.scrollSpeed += 200 + CGFloat(self.offset)
//                self.halt = false
            }
//            the speed animation counts as the seconds to turn halt back off
//            turn on halt AND call increase speed function!
            halt = false
        }
    }
    
    func updateObstacles() {
        /* Update Obstacles */
       
        //        position movement
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -12.5 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                pingWalls.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.1 {
            
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
//            print(counterTest)
            
            obsCounter += 1
            
            
            
            
            if counterTest == 3 {
                halt = true
                startWallUpdate = false
                secondEnemyStart = true
                
//                increaseSpeed()
            }
            // Reset spawn timer
            spawnTimer = 0
          
        }
        
    }
    
    func blueStarterFix() {
        if blueSpawnBool == true {
            spawnTimer = 0
            blueSpawnBool = false
        }
    }
   
    func yellowStarterFix() {
        if yellowSpawnBool == true {
            spawnTimer = 0
            yellowSpawnBool = false
        }
    }
    
    func updateObstacles2() {
        /* Update Obstacles */
        
        //        position movement
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            print(nullPosition.x)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -12.5 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                blueWalls.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        
        blueStarterFix()
        
        if spawnTimer >= 0.8 {
            
            
            
            /* Create a new obstacle by copying the source obstacle */
            let newBlueWalls = blueWalls.copy() as! SKNode
            nullPoint.addChild(newBlueWalls)
            //            Shows when a new wall is created
            print("im a BLUe brick boii")
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newBlueWalls.position = self.convert(randomPosition, to: nullPoint)
            
            blueCounter += 1
            print(blueCounter)
            
            obsCounter += 1
           
            
            if blueCounter == 7 {
                halt = true
                secondEnemyStart = false
                thirdEnemyStart = true
//                increaseSpeed()
            }
            
            // Reset spawn timer
            spawnTimer = 0
        }
        
    }
   
    
    func updateObstacles3() {
        /* Update Obstacles */
        
        //        position movement
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -12.5 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                yellowWalls.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        yellowStarterFix()
        
        if spawnTimer >= 0.8 {
            
            
            
            /* Create a new obstacle by copying the source obstacle */
            let newYellowWalls = yellowWalls.copy() as! SKNode
            nullPoint.addChild(newYellowWalls)
            //            Shows when a new wall is created
            print("im a yellow brick boii")
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newYellowWalls.position = self.convert(randomPosition, to: nullPoint)
            
            yellowCounter += 1
            print(yellowCounter)
            
//            if counterTest == 5 {
//                startWallUpdate = false
//            }
            
            obsCounter += 1
            
            if yellowCounter == 7 {
                halt = true
                thirdEnemyStart = false
                slicerActivation = true
                //                increaseSpeed()
            }

            
            // Reset spawn timer
            spawnTimer = 0
        }
        
    }

    func slicerStart() {
        if slicerStartBool == true{
            slicerTimer = 0
            slicerStartBool = false
        }
    }
    
    func slicerENGAGE() {
//        /* Update Obstacles */
//        
//        //        position movement
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
//        
//        /* Loop through obstacle layer nodes */
//        for obstacle in nullPoint.children as! [SKReferenceNode] {
//            
//            /* Get obstacle node position, convert node position to scene space */
//            let nullPosition = nullPoint.convert(obstacle.position, to: self)
//            
//            /* Check if obstacle has left the scene */
//            if nullPosition.x <= -26 {
//                // 26 is one half the width of an obstacle
//                
//                /* Remove obstacle node from obstacle layer */
//                pingWalls.removeFromParent()
//            }
        
//        }
        
        /* Time to add a new obstacle? */
//       slicerTimer = 0
        
        
        
        
        
       slicerStart()
        
        if slicerTimer >= 0.5 {
            scrollSpeed = 777
        slicer.position.y += scrollSpeed * CGFloat(fixedDelta)
            
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
//            print(points)
            //        jump.isUserInteractionEnabled = true
            
        }
        
        if nodeA.physicsBody?.categoryBitMask == 8 || nodeB.physicsBody?.categoryBitMask == 8 {
            
            if nodeA.physicsBody?.categoryBitMask == 8 {
                nodeB.removeFromParent()
               obsRemoval = true
                print("true")
            }
            
            if nodeB.physicsBody?.categoryBitMask == 8 {
                nodeA.removeFromParent()
                obsRemoval = true
                print("true")
            }
            
        }
        
        
        if nodeA.physicsBody?.categoryBitMask == 16 || nodeB.physicsBody?.categoryBitMask == 16{
            points += 1
            scoreLabel.text = String(points)
            //            print(points)
            //        jump.isUserInteractionEnabled = true
            return
        }
        
        if nodeA.physicsBody?.categoryBitMask == 16 || nodeB.physicsBody?.categoryBitMask == 16{
            points += 1
            scoreLabel.text = String(points)
            //            print(points)
            //        jump.isUserInteractionEnabled = true
            return
        }
        
        //    gameOver()
        restartButton.state = .MSButtonNodeStateActive
        
    }
    
    func obstacleChecker() {
        if obsRemoval == true {
            obsCounter -= 1
            obsRemoval = false
        }
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
        
        obstacleChecker()
        
        //    print(invincibility)
        //    print(jump.isUserInteractionEnabled)
        
//        slicer.
        print(nullPoint.children.count)
        if state != .gameOver{
            nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        }
        
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
        slicerTimer += fixedDelta
        
        if bounceBool == true {bounceTimer += fixedDelta}
        //        if spawnTimer >= 10{
        //            gameOver()
        //        }
        
//        slicerENGAGE()
        slicerTimer += fixedDelta
        delayTimer += fixedDelta
//        print(nullPoint.children)
//        print("I equal \(nullPoint.children.count)")
        
        if halt == true{
            if obsCounter == 0 && state != .gameOver{
            
                scrollSpeed = 0
            
                increaseSpeed()
                
            }
        }
        
        print("im the obs counter of\(obsCounter)")
        
        if startWallUpdate && !halt {
            updateObstacles()
            
        } else if secondEnemyStart && !halt {
            
//            if self.delayTimer >= 3.0{
//            self.scrollSpeed = 250
//                self.delayTimer = 0
//            }
            updateObstacles2()
        } else if thirdEnemyStart && !halt {
//            
//            if self.delayTimer >= 3.0{
//               self.scrollSpeed = 350
//            self.delayTimer = 0
//            }
        
        
            updateObstacles3()
//            nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        } else if slicerActivation && !halt {
            slicerENGAGE()
        }
        
        
        
    
    
    }
}
