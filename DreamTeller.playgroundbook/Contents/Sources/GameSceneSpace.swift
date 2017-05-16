import SpriteKit
import GameplayKit

public let kAnimalNodeName = "movable"

public class GameSceneSpace: SKScene, SKPhysicsContactDelegate {
    
    var background: SKSpriteNode!
    var player:SKSpriteNode!
    var lifesLabel: SKLabelNode!
    var enemyLabel: SKLabelNode!
    var number = 0
    var score = 0
    var naveLife = 0
    var naveBorn = 0
    var life = 3
    var flag = false
    var gameTimer:Timer!
    var gameTimer2:Timer!
    var result: SKLabelNode!
    var result2: SKLabelNode!
    public var velocityAndroids: Double!
    public var numberAndroids: Int!
    public var shotsToKill: Int!
    public var shotsPerSec: Double!
    
    
    
    let alienCategory:UInt32 = 0x1 << 1
    let alienShipCategory:UInt32 = 0x1 << 2
    let photonTorpedoCategory:UInt32 = 0x1 << 0
    
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        
        self.scaleMode = .aspectFill

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameSceneSpace.handlePanFrom(_:)))
        self.view!.addGestureRecognizer(gestureRecognizer)
        
        player = SKSpriteNode(imageNamed: "hero")
        let h = (player.texture?.size().width)! * view.frame.size.height/view.frame.size.width
        player.size = CGSize(width: (player.texture?.size().width)!, height: h)
        player.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 5)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = photonTorpedoCategory
        player.physicsBody?.contactTestBitMask = alienCategory | alienShipCategory
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.name = kAnimalNodeName
        player.setScale(0.15)
        
        result = SKLabelNode.init(text: "")
        result.fontName = "Gameplay"
        result.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        result.fontColor = .red
        result.fontSize = 40
        result.zPosition = 10
        
        let zoomInAction = SKAction.scale(to: 0.9, duration: 0.3)
        let zoomOut = SKAction.scale(to: 1, duration: 0.3)
        let seq = SKAction.sequence([zoomInAction, zoomOut])
        let foreva = SKAction.repeatForever(seq)
        
        result.run(foreva)
        
        result2 = SKLabelNode.init(text: "")
        result2.fontName = "Gameplay"
        result2.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 35)
        result2.fontColor = .white
        result2.fontSize = 30
        result2.zPosition = 10

        result2.run(foreva)
        
        
        lifesLabel = SKLabelNode.init(text: "LIVES: \(life)x")
        lifesLabel.fontName = "Gameplay"
        lifesLabel.position = CGPoint(x: 0 + self.lifesLabel.frame.width/4 + 3, y: self.frame.height - self.lifesLabel.frame.height/2)
        lifesLabel.fontColor = .white
        lifesLabel.fontSize = 16
        lifesLabel.zPosition = 5
        
        enemyLabel = SKLabelNode.init(text: "ANDROIDS KILLED: \(score)")
        enemyLabel.fontName = "Gameplay"
        enemyLabel.position = CGPoint(x: self.frame.width - self.enemyLabel.frame.width/4 - 10, y: self.frame.height - self.enemyLabel.frame.height/2)
        enemyLabel.fontColor = .white
        enemyLabel.fontSize = 16
        enemyLabel.zPosition = 5

        self.addChild(lifesLabel)
        self.addChild(enemyLabel)
        
        let change = SKAction.animate(with: [SKTexture.init(imageNamed: "hero"), SKTexture.init(imageNamed: "hero2")], timePerFrame: 0.3)
        player.run(SKAction.repeatForever(change))
        
        makeBackground()
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.addChild(player)

        self.addChild(result)
        self.addChild(result2)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        if velocityAndroids > 100 {
            velocityAndroids = 100
        } else if velocityAndroids <= 0{
            velocityAndroids = 1
        }
        if numberAndroids > 30 {
            numberAndroids = 30
        } else if numberAndroids < 10{
            numberAndroids = 10
        }
        if shotsToKill > 10 {
            shotsToKill = 10
        } else if shotsToKill < 2{
            shotsToKill = 2
        }
        if shotsPerSec > 20{
            shotsPerSec = 20
        } else if shotsPerSec < 5 {
            shotsPerSec = 5
        }
        
    }
    
    func makeBackground() {
        let track = SKAction.playSoundFileNamed("back.mp3", waitForCompletion: true)
        self.run(SKAction.repeatForever(track))
        let backgroundTexture = SKTexture(imageNamed: "backgroundSpace.jpeg")
        
        let shiftBackground = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height, duration: 35)
        let replaceBackground = SKAction.moveBy(x: 0, y:backgroundTexture.size().height, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        
        for i in 0...3 {
            background = SKSpriteNode(texture:backgroundTexture)
            background.position = CGPoint(x: self.frame.midX, y: backgroundTexture.size().height/2 + (backgroundTexture.size().height * CGFloat(i)))
            background.size.width = self.frame.width
            background.run(movingAndReplacingBackground)
            background.zPosition = -1
            background.name = "background"
            self.addChild(background)
        }
    }
    
    func addAlien () {
        let alien = SKSpriteNode(imageNamed: "android")
        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(self.frame.width)/4, highestValue: 3*Int(self.frame.width/4))
        let position = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.size.height + 30)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory | alienCategory
        alien.physicsBody?.collisionBitMask = alienCategory
        alien.setScale(0.10)
        self.addChild(alien)
        alien.name = "alien"
        
        let animationDuration:TimeInterval = 100/velocityAndroids
        var actionArray = [SKAction]()
        
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y:  self.frame.height/2), duration: animationDuration))
        alien.run(SKAction.sequence(actionArray))
        
        let change = SKAction.animate(with: [SKTexture.init(imageNamed: "android"), SKTexture.init(imageNamed: "android2")], timePerFrame: 0.3)
        alien.run(SKAction.repeatForever(change))
        
        number += 1
        if number == numberAndroids+1{
            flag = true
        }
    }
    
    func addAlienShip () {
        let alien = SKSpriteNode(imageNamed: "AndroidShip")
        
        alien.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height + 75)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        alien.physicsBody?.categoryBitMask = alienShipCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory | alienCategory
        alien.physicsBody?.collisionBitMask = 0
        alien.setScale(0.10)
        self.addChild(alien)
        alien.name = "alien"
        
        let animationDuration:TimeInterval = 100/velocityAndroids
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), duration: animationDuration))
        
        alien.run(SKAction.sequence(actionArray))
        
        let change = SKAction.animate(with: [SKTexture.init(imageNamed: "AndroidShip"), SKTexture.init(imageNamed: "AndroidShip 2")], timePerFrame: 0.3)
        alien.run(SKAction.repeatForever(change))
        
        let track = SKAction.playSoundFileNamed("alienShip.mp3", waitForCompletion: true)
        alien.run(SKAction.repeatForever(track))
    }
    
    
    func handlePanFrom(_ recognizer : UIPanGestureRecognizer) {
        if recognizer.state == .began {
            var touchLocation = recognizer.location(in: recognizer.view)
            touchLocation = self.convertPoint(fromView: touchLocation)
            gameTimer2 = Timer.scheduledTimer(timeInterval: 1/shotsPerSec, target: self, selector: #selector(fireTorpedo), userInfo: nil, repeats: true)
            self.selectNodeForTouch(touchLocation)
            
        } else if recognizer.state == .changed {
            var translation = recognizer.translation(in: recognizer.view!)
            translation = CGPoint(x: translation.x, y: -translation.y)
            
            self.panForTranslation(translation)
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
            
        } else if recognizer.state == .ended {
            gameTimer2.invalidate()
            if player.name != kAnimalNodeName {
                let scrollDuration = 0.2
                let velocity = recognizer.velocity(in: recognizer.view)
                let pos = player.position
                gameTimer2.invalidate()
                
                // This just multiplies your velocity with the scroll duration.
                let p = CGPoint(x: velocity.x * CGFloat(scrollDuration), y: velocity.y * CGFloat(scrollDuration))
                
                var newPos = CGPoint(x: pos.x + p.x, y: pos.y + p.y)
                newPos = self.boundLayerPos(newPos)
                
                let moveTo = SKAction.move(to: newPos, duration: scrollDuration)
                moveTo.timingMode = .easeOut
                player.run(moveTo)
            }
        }
    }
    
    func degToRad(_ degree: Double) -> CGFloat {
        return CGFloat(degree / 180.0 * .pi)
    }
    
    func selectNodeForTouch(_ touchLocation : CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is SKSpriteNode {
            if !player.isEqual(touchedNode) {
                player.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                if touchedNode.name! == kAnimalNodeName {
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(-4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(4.0), duration: 0.1)])
                    player.run(SKAction.repeatForever(sequence))
                }
            }
        }
    }
    
    
    func boundLayerPos(_ aNewPosition : CGPoint) -> CGPoint {
        let winSize = self.size
        var retval = aNewPosition
        retval.x = CGFloat(min(retval.x, 0))
        retval.x = CGFloat(max(retval.x, -(background.size.width) + winSize.width))
        retval.y = self.position.y
        
        return retval
    }
    
    
    func panForTranslation(_ translation : CGPoint) {
        let position = player.position
        if player.name! == kAnimalNodeName {
            player.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        }
    }
    
    
    func fireTorpedo() {
        if life > 0{
            self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: true))
            let torpedoNode = SKSpriteNode(imageNamed: "laser")
            torpedoNode.position = player.position
            torpedoNode.position.y += 120
            torpedoNode.position.x += 23
            torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
            torpedoNode.physicsBody?.isDynamic = true
            torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
            torpedoNode.physicsBody?.contactTestBitMask = alienCategory
            torpedoNode.physicsBody?.collisionBitMask = 0
            torpedoNode.setScale(0.075)
            torpedoNode.name = "torpedo"
            self.addChild(torpedoNode)
            
            let animationDuration:TimeInterval = 0.5
            var actionArray = [SKAction]()
            actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            
            torpedoNode.run(SKAction.sequence(actionArray))
        }
    }
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody!
        var secondBody:SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            if secondBody.node as? SKSpriteNode != nil && firstBody.node as? SKSpriteNode != nil{
                torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
            }
        }
        
        if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & alienShipCategory) != 0 {
            if secondBody.node as? SKSpriteNode != nil && firstBody.node as? SKSpriteNode != nil{
                torpedoDidCollideWithAlienShip(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
                naveLife += 1
            }
        }
        
        if (firstBody.categoryBitMask & alienCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            if (secondBody.node as? SKSpriteNode != nil) && (firstBody.node as? SKSpriteNode != nil) && ((firstBody.node?.position.y)! > self.frame.height ) && ((secondBody.node?.position.y)! > self.frame.height){
                if Double((firstBody.node?.position.y)!) < Double((secondBody.node?.position.y)!){
                    secondBody.node?.removeFromParent()
                } else{
                    firstBody.node?.removeFromParent()
                }
                number -= 1
            }
        }
    }
    
    
    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        if torpedoNode.size != player.size{
            torpedoNode.removeFromParent()
        }
        else{
            life -= 1
            if life <= 0{
                torpedoNode.removeFromParent()
            }
        }
        
        alienNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        score += 1
    }
    
    
    func torpedoDidCollideWithAlienShip (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        if torpedoNode.size == player.size{
            torpedoNode.removeFromParent()
            life = 0
        }
            
        else if torpedoNode.size != player.size{
            torpedoNode.removeFromParent()
        }
        
        if naveLife >= shotsToKill-1{
            print(naveLife)
            alienNode.removeFromParent()
        }
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
    }
    
    
    override public func didSimulatePhysics() {
        if player.position.x < 26{
            player.position = CGPoint(x: player.frame.width/2, y: player.position.y)
        } else if player.position.x > self.frame.width - self.player.frame.width/2 {
            player.position = CGPoint(x: self.size.width - player.frame.width/2, y: player.position.y)
        } else if player.position.y > self.frame.height - self.player.frame.height/2 {
            player.position = CGPoint(x: player.position.x, y: self.frame.height - self.player.frame.height/2)
        } else if player.position.y < self.player.frame.height/2 {
            player.position = CGPoint(x: player.position.x, y:  self.player.frame.height/2)
        }
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
        print("number \(number)")
        print("score \(score)")
        print("naveLife \(naveLife)")
        print("life \(life)")
        
        if numberAndroids == number && score > numberAndroids{
            enemyLabel.text = "ANDROIDS KILLED: \(numberAndroids)"
        }
        else{
            enemyLabel.text = "ANDROIDS KILLED: \(score)"
        }
        
        if life > 0{
            lifesLabel.text = "LIVES: \(life)"
        }
        
        if flag{
            self.gameTimer.invalidate()
            if ((naveLife == 0) && (naveBorn == 0) && score == number){
                self.addAlienShip()
                self.naveBorn = 1
            }
        }
        
        if naveLife >= shotsToKill{
            self.result.text = "YOU WIN!"
            self.result2.text = "GO TO THE NEXT PAGE!"
        }
        
        if life <= 0{
            lifesLabel.text = "LIVES: 0"
            self.result.text = "GAME OVER!"
            self.result2.text = "TRY AGAIN OR GO TO THE NEXT PAGE!"
        }
        
        
    }
}
