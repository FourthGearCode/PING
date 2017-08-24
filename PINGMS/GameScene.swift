//
//  GameScene.swift
//  PINGMS
//
//  Created by Jose Gutierrez on 7/25/17.
//  Copyright © 2017 JoseMake. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum GameState {
    case title, ready, playing, gameOver
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var state: GameState = .ready
    
    var arrayNode: SKNode!
    
    var counterTest: Int = 0
    
    var blueCounter: Int = 0
    
    var yellowCounter: Int = 0
    
    
    var firstText: SKLabelNode!
    
    var pingBall: SKSpriteNode!
    
    var pingBallOuter: SKSpriteNode!
    
    var redScalpel: SKReferenceNode!
    
    var blueScalpel: SKReferenceNode!
    
    var yellowScalpel: SKReferenceNode!
    
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
    
    var runningAnimation = false
    
    let defaults = UserDefaults.standard // makes code connection to phone memory
    
    var highScoreLabel: SKLabelNode!
    
    var highScoreLabelB: SKLabelNode!
    
    //    var leftPressed = false
    //
    //    var rightPressed = false
    
    var timesDouble = 200.0 {
        //        didSet will act as a function if the variable is changed
        didSet{
            if timesDouble == 0{
                timesDouble = 0
            }
            else if timesDouble < 25.0 {
                timesDouble = 25.0
            }
            if timesDouble > 200.0 {
                timesDouble = 200.0
            }
        }
    }
    
    var particleShiftCheck = Bool()
    
    
    
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
    
//    var needleScene: SKSpriteNode!
    
    var pauseMovement = false
    
    let pingParticle = SKEmitterNode(fileNamed: "pingEmitter")!
    
    let needleIntro = SKVideoNode(fileNamed: "updatedNeedleInt.mov")
    
    var quitButton: MSButtonNode!
    
    var quitLabel: SKLabelNode!
    
    var letterD: SKLabelNode!
    
    var letterDBack: SKLabelNode!
    
    var letterI: SKLabelNode!
    
    var letterIBack: SKLabelNode!
    
    var letterE: SKLabelNode!
    
    var letterEBack: SKLabelNode!
    
    var letterCounter = 0
    
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        addChild(pingParticle)

        
       
        
//        arrayNode = self.childNode(withName: "arrayNode") as! SKNode
        
        pingBall = self.childNode(withName: "pingBall") as! SKSpriteNode
        
        pingBallOuter = pingBall.childNode(withName: "pingBallOuter") as! SKSpriteNode
        
        redScalpel = self.childNode(withName: "redScalpel") as! SKReferenceNode
        
        blueScalpel = self.childNode(withName: "blueScalpel") as! SKReferenceNode
        
        yellowScalpel = self.childNode(withName: "yellowScalpel") as! SKReferenceNode
        
        firstText = self.childNode(withName: "//text1") as! SKLabelNode
        
//        slicer = self.childNode(withName: "slicer") as! SKReferenceNode
        
        nullPoint = self.childNode(withName: "nullPoint")
        
        rightTouch = self.childNode(withName: "rightTouch") as! SKSpriteNode
        
        leftTouch = self.childNode(withName: "leftTouch") as! SKSpriteNode
        
        deathLabel = self.childNode(withName: "deathLabel") as! SKLabelNode
        
        restartLabel = self.childNode(withName: "restartLabel") as! SKLabelNode
        
        restartButton = self.childNode(withName: "//restartButton") as! MSButtonNode
        
        quitButton = self.childNode(withName: "//quitButton") as! MSButtonNode
        
        quitLabel = self.childNode(withName: "quitTxt") as! SKLabelNode
        
        jump = self.childNode(withName: "JUMP") as! SKSpriteNode
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        
        theLight = self.childNode(withName: "theLight") as! SKSpriteNode
        
//        let bottomPosition = CGPoint(x: 284, y: -100)
        
//        slicer.position = bottomPosition
        
        highScoreLabel = childNode(withName: "highScoreLabel") as! SKLabelNode
        
        highScoreLabelB = childNode(withName: "highScoreLabelB") as! SKLabelNode
        
        highScoreLabel.isHidden = true
        
        highScoreLabelB.isHidden = true
        
        scoreLabel.isHidden = false
        
        
        letterD = self.childNode(withName: "Dword") as! SKLabelNode
        
        letterDBack = self.childNode(withName: "DwordBack") as! SKLabelNode
        
        letterI = self.childNode(withName: "Iword") as! SKLabelNode
        
        letterIBack = self.childNode(withName: "IwordBack") as! SKLabelNode
        
        letterE = self.childNode(withName: "Eword") as! SKLabelNode
        
        letterEBack = self.childNode(withName: "EwordBack") as! SKLabelNode

        
//        needleScene = self.childNode(withName: "needleScene") as! SKSpriteNode
        
//        pingParticle = self.childNode(withName: "pingParticle") as! SKEmitterNode
        
        
        
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
        
        quitButton.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Variable for loading Game scene */
            let scene = MainMenu(fileNamed: "pressStart") as MainMenu!
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView?.presentScene(scene)
            
            /* Hide restart button */
            self.quitButton.state = .MSButtonNodeStateHidden
        }
        
        self.quitLabel.isHidden = true
        
        self.restartLabel.isHidden = true
        
        self.deathLabel.isHidden = true

//        pingPath = childNode(withName: "pingPath") //as! GKGraph
        
        physicsWorld.contactDelegate = self
        
    }
    
    func needleVideo() {
        needleIntro.position = CGPoint(x: 284, y: 160)
        needleIntro.zPosition = 2000
        needleIntro.size.height = 320 //self.frame.height
        needleIntro.size.width = 568//self.frame.width
        addChild(needleIntro)
        needleIntro.play()
        print("kkkkkkkkk")
    }
    
   
    
   
    
    func gameOver() {
        /* Game over! */
        
        if invincibility == true{return}
        
        state = .gameOver
        
        self.restartLabel.isHidden = false
        
        self.deathLabel.isHidden = false
        
        self.quitLabel.isHidden = false
        
        highScoreLabel.isHidden = false
        
        highScoreLabelB.isHidden = false
        
        scoreLabel.isHidden = true
        
        
        let previousScore = defaults.integer(forKey: "highScore")
        if points > previousScore {
            defaults.set(points, forKey: "highScore")
        }
        highScoreLabel.text = String(defaults.integer(forKey: "highScore"))
        
         highScoreLabelB.text = String(defaults.integer(forKey: "highScore"))

        
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
//        let popIn = SKAction.fadeAlpha(to: 1, duration: 0.1)
//        let slowFade = SKAction.fadeAlpha(to: 0, duration: 1)
//        
//        if letterCounter == 0{
        
        if  obsCounter == 0 && state != .gameOver {
           
//            print("runtheD")
//            
//            letterD.run(SKAction.sequence([popIn, slowFade]))
//            
//            letterDBack.run(SKAction.sequence([popIn, slowFade])){

//            self.timesDouble = 0
            
                self.scrollSpeed += 50 + CGFloat(self.offset)

//                self.timesDouble = 200
//                self.halt = false
            
//            the speed animation counts as the seconds to turn halt back off
//            turn on halt AND call increase speed function!
            
                self.halt = false
                
//                self.letterCounter += 1
//            }
//        }
    }
        
//        if letterCounter == 1{
        
            if  obsCounter == 0 && state != .gameOver {
                
//                print("runtheDI")
//                
//                letterD.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterDBack.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterI.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterIBack.run(SKAction.sequence([popIn, slowFade])){
                
                    //            self.timesDouble = 0
                    
                    self.scrollSpeed += 50 + CGFloat(self.offset)
                    
                    //                self.timesDouble = 200
                    //                self.halt = false
                    
                    //            the speed animation counts as the seconds to turn halt back off
                    //            turn on halt AND call increase speed function!
                    
                    self.halt = false
                    
//                    self.letterCounter += 1
//                }
//            }
        }
        
//        if letterCounter == 2{
        
            if  obsCounter == 0 && state != .gameOver {
                
                print("runtheDIE")
                
//                letterD.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterDBack.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterI.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterIBack.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterE.run(SKAction.sequence([popIn, slowFade]))
//                
//                letterEBack.run(SKAction.sequence([popIn, slowFade])){
                
                    //            self.timesDouble = 0
                    
                    self.scrollSpeed += 50 + CGFloat(self.offset)
                    
                    //                self.timesDouble = 200
                    //                self.halt = false
                    
                    //            the speed animation counts as the seconds to turn halt back off
                    //            turn on halt AND call increase speed function!
                    
                    self.halt = false
                    
//                    self.letterCounter += 1
//                }
//            }
        }
//        print("this is my letterCounter of  \(letterCounter)")
}
    func updateObstacles() {
        /* Update Obstacles */
       
        //        position movement
//        nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in nullPoint.children {
            
            /* Get obstacle node position, convert node position to scene space */
            let nullPosition = nullPoint.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -12.5 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                redScalpel.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.1 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newRedScalpel = redScalpel.copy() as! SKNode
            nullPoint.addChild(newRedScalpel)
            //            Shows when a new wall is created
           
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newRedScalpel.position = self.convert(randomPosition, to: nullPoint)
            
            counterTest += 1

            
            obsCounter += 1
            
            
            
            
            if counterTest == 50 {
//                halt = true
                startWallUpdate = false
                secondEnemyStart = true
                
                increaseSpeed()
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
            
          
            
            /* Check if obstacle has left the scene */
            if nullPosition.x <= -12.5 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                blueScalpel.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        
        blueStarterFix()
        
        if spawnTimer >= 0.8 {
            
            
            
            /* Create a new obstacle by copying the source obstacle */
            let newBlueScalpel = blueScalpel.copy() as! SKNode
            nullPoint.addChild(newBlueScalpel)
            //            Shows when a new wall is created
          
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newBlueScalpel.position = self.convert(randomPosition, to: nullPoint)
            
            blueCounter += 1
            print("im blue\(blueCounter)")
            
            obsCounter += 1
           
            blue will hit after 50 red and yellow after 100 bluw
            
            oh I was about to do it... but you already did.... THE enD
            
            
            *thumbs up emoji*
            *flip off emoji*
            
            why
            because everything is going to shit or at least being half assed
            
            the damn render is only half way done and I still didnt send my resume. I cant tell if that shows my incompetence or ..... idfk
            
            We'll skip this for now then'
            if blueCounter == 100 {
//                halt = true
                secondEnemyStart = false
                thirdEnemyStart = true
                increaseSpeed()
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
                yellowScalpel.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        yellowStarterFix()
        
        if spawnTimer >= 0.8 {
            
            
            
            /* Create a new obstacle by copying the source obstacle */
            let newYellowScalpel = yellowScalpel.copy() as! SKNode
            nullPoint.addChild(newYellowScalpel)
            //            Shows when a new wall is created
            print("im a yellow brick boii")
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 70, max: 270))
            
            /* Convert new node position back to obstacle layer space */
            newYellowScalpel.position = self.convert(randomPosition, to: nullPoint)
            
            yellowCounter += 1
            print(yellowCounter)
            
//            if counterTest == 5 {
//                startWallUpdate = false
//            }
            
            obsCounter += 1
            
//            if yellowCounter == 7 {
////                halt = true
//                thirdEnemyStart = false
//                slicerActivation = true
//                //                increaseSpeed()
//            }

            
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
            
            else if nodeB.physicsBody?.categoryBitMask == 8 {
                nodeA.removeFromParent()
                self.obsRemoval = true
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
            print("removed")
           print("\(nullPoint.children.isEmpty)")
            obsCounter -= 1
            obsRemoval = false
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        //let nodeA = contactA.node!
        //let nodeB = contactB.node!
        
        if contactA.node?.physicsBody?.categoryBitMask == 2 && contactB.node?.physicsBody?.categoryBitMask == 1 ||
            contactA.node?.physicsBody?.categoryBitMask == 1 && contactB.node?.physicsBody?.categoryBitMask == 2{
            if self.invincibility {return}
            
            if self.invincibility == false {
                gameOver()
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        pingParticle.position = pingBall.position
        
        obstacleChecker()
        if halt == true  {
            print("im true boii")
        }
        //    print(invincibility)
        //    print(jump.isUserInteractionEnabled)
        
//        slicer.
      //  print(nullPoint.children.count)
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
            pingParticle.yAcceleration = -200
        }else if up != true{
            pingBall.position.y -= CGFloat(fixedDelta * timesDouble)
            pingParticle.yAcceleration = 200
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
      //  print(nullPoint.children)
        print("I equal \(nullPoint.children.count)")
        
        if halt == true{
            if obsCounter == 0 && state != .gameOver{
            
                scrollSpeed = 0
            print("should increase speed")
                increaseSpeed()
                
            }
        }
        
//        What happen when it spells out DIE? It just stays there? <<<< So yes? the die appears and fades away, then the scalpels come in

//        But then what?
//        
//        after it spells DIE. the yellow spawns infinitely. I thought it was a nice little touch that could be implemented easily but ummm.... no *Thumbs up emoji*
//        when game loads
//        D
//        red scalpels
//        DI
//        blue scalpels
//        DIE
//        yellow scalpels(infinite)
//        Release it in an update and just push inf pls
//        FIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIINE *Thumbs up emoji*
        print("im the obs counter of\(obsCounter)")
        
        if startWallUpdate /*&& !halt*/ {
            updateObstacles()
            
        } else if secondEnemyStart /*&& !halt*/ {
            
//            if self.delayTimer >= 3.0{
//            self.scrollSpeed = 250
//                self.delayTimer = 0
//            }
            updateObstacles2()
        } else if thirdEnemyStart /*&& !halt*/ {
//            
//            if self.delayTimer >= 3.0{
//               self.scrollSpeed = 350
//            self.delayTimer = 0
//            }
        
        
            updateObstacles3()
//            nullPoint.position.x -= scrollSpeed * CGFloat(fixedDelta)
        }
//            else if slicerActivation && !halt {
//            slicerENGAGE()
//        }
        
        print("isempty "+"\(nullPoint.children.isEmpty)")
        
    
    
    }
}
