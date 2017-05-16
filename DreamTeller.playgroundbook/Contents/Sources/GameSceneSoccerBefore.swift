import SpriteKit
import UIKit
import Foundation

public struct PhysicsType {
    static let none: UInt32 = 0
    static let ball: UInt32 = 1
    static let hoop: UInt32 = 2
    static let rim:  UInt32 = 4
    static let edge: UInt32 = 8
    static let keeper: UInt32 = 16
}

public class GameSceneBefore: SKScene {
    
    var ball: SKSpriteNode!
    var goalKeeper: SKSpriteNode!
    var player: SKSpriteNode!
    var playerKick: SKSpriteNode!
    var playerCel: SKSpriteNode!
    var playerBad: SKSpriteNode!
    var hand: SKSpriteNode!
    var arrow: SKSpriteNode!
    var timeLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var score: Int = 0
    var hoopSize: CGSize!
    var hoopRect: CGRect!
    var hoop: SKShapeNode!
    var rimLeft: SKShapeNode!
    var rimRight: SKShapeNode!
    var rimUp: SKShapeNode!
    var background: SKSpriteNode!
    var timer = CowntdownLabel()
    var goal: SKSpriteNode!
    var gameScene: SKScene!
    public var kickPower: CGFloat = 1.0
    public var goalKeeperVelocity: CGFloat = 2.0

    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGameScene() {
        print(self.frame.width)
        print(self.frame.height)
        
        if gameScene == nil {
            gameScene = SKScene(size: frame.size)
        }
        
        timer.startWithDuration(11111)
        
        let tex2 = SKTexture.init(imageNamed: "SoccerField_02")
        
        self.background = SKSpriteNode(texture: tex2, size: CGSize(width: self.frame.width, height: self.frame.height))
        self.background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(background)
    
        self.scaleMode = .aspectFill
        
        let location = CGPoint(x: self.frame.width - 40 , y: self.frame.height / 600)
        
        self.arrow = SKSpriteNode(imageNamed: "seta")
        self.arrow.position = CGPoint(x: self.frame.width/2 , y: (self.frame.height / 2))
        self.arrow.setScale(0.5)
        self.arrow.zPosition = 5
        self.addChild(arrow)
        
        self.player = SKSpriteNode(imageNamed: "pedrinho")
        self.player.position.y = self.frame.height/4.8
        self.player.position.x = self.frame.width/2 - 50
        self.player.setScale(0.14)
        self.player.isHidden = true
        
        let location2 = CGPoint(x: self.frame.width / 1.45, y: self.frame.height / 6)
        
        self.hand = SKSpriteNode(imageNamed: "hand")
        self.hand.position = location2
        self.hand.setScale(0.45)
        self.hand.zPosition = 5
        self.addChild(hand)
        
        self.playerKick = SKSpriteNode(imageNamed: "pedrinhoKick")
        self.playerKick.position.y = self.frame.height/4.8
        self.playerKick.position.x = self.frame.width/2 - 50
        self.playerKick.setScale(0.15)
        self.playerKick.isHidden = true
        
        self.playerBad = SKSpriteNode(imageNamed: "bad")
        self.playerBad.position.y = self.frame.height/4.8
        self.playerBad.position.x = self.frame.width/2 - 50
        self.playerBad.setScale(0.15)
        self.playerBad.isHidden = true
        
        self.playerCel = SKSpriteNode(imageNamed: "celeb")
        self.playerCel.position.y = self.frame.height/4.8
        self.playerCel.position.x = self.frame.width/2 - 50
        self.playerCel.setScale(0.15)
        self.playerCel.isHidden = true
        
        
        let move = SKAction.moveBy(x: 0, y: 100, duration: 0.75)
        let fade = SKAction.fadeOut(withDuration: 0.5)
        let moveBack = SKAction.moveBy(x: 0, y: -100, duration: 0.000001)
        let fadeIn = SKAction.fadeIn(withDuration: 0.0001)
        let loop = SKAction.sequence([move, fade, moveBack, fadeIn])
        
        let fadeut = SKAction.fadeOut(withDuration: 0.000001)
        let fadeinn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 0.75)
        let seq = SKAction.sequence([wait, fadeinn, fadeut])
        
        
        self.arrow.run(SKAction.repeatForever(seq))
        
        hand.run(SKAction.repeatForever(loop))
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody!.categoryBitMask = PhysicsType.edge
        physicsBody?.collisionBitMask = PhysicsType.ball
        physicsBody?.isDynamic = true
        self.backgroundColor = UIColor.white
        let transition = SKTransition.fade(with: UIColor.darkGray, duration: 1.0)
        view?.presentScene(gameScene, transition: transition)
        
        createRim()

        self.addChild(playerKick)
        self.addChild(player)
        self.addChild(playerCel)
        self.addChild(playerBad)
        
    }
    
    
    func createBall(_ index: Int) {
        let location = CGPoint(x: self.frame.width / 2, y: self.frame.height / 6)
        
        ball = SKSpriteNode(imageNamed: "ball")
        ball.setScale(0.15)
        
        ball.position = location
        ball.alpha = 0.0
        ball.zPosition = 3
        ball.name = "activeBall-\(index)"
        
        let ballBody = SKPhysicsBody(texture: SKTexture.init(image: UIImage(named:"ball")!), size: self.ball.size)
        ballBody.affectedByGravity = false
        ballBody.categoryBitMask = PhysicsType.ball
        ballBody.collisionBitMask = PhysicsType.rim | PhysicsType.keeper
        ballBody.contactTestBitMask = PhysicsType.hoop | PhysicsType.edge | PhysicsType.keeper
        ballBody.usesPreciseCollisionDetection = true
        ball.physicsBody = ballBody
        scene?.addChild(ball)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.05)
        ball.run(fadeIn)
        
    }
    
    func createRim() {
        goal = SKSpriteNode(imageNamed: "goal")
        goal.physicsBody = SKPhysicsBody(texture: goal.texture!, size: (goal.texture?.size())!)
        goal.physicsBody?.isDynamic = false
        goal.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.470)
        goal.physicsBody?.categoryBitMask = PhysicsType.hoop
        goal.physicsBody?.contactTestBitMask = PhysicsType.ball
        goal.physicsBody?.collisionBitMask = PhysicsType.none
        goal.physicsBody?.usesPreciseCollisionDetection = true
        goal.physicsBody?.affectedByGravity = false
        goal.physicsBody?.allowsRotation = false
        goal.zPosition = 2
        goal.setScale(0.2)
        scene?.addChild(goal)
        
        let rimSize = CGSize(width: 10, height: 94)
        let rimRectLeft = CGRect(x: (self.frame.width / 2) - goal.size.width/2 - 1, y: goal.position.y - goal.frame.height/2, width: rimSize.width, height: rimSize.height)
        let rimRectRight = CGRect(x: (self.frame.width / 2) + goal.size.width/2 - 6, y: goal.position.y - goal.frame.height/2, width: rimSize.width, height: rimSize.height)
        let rimRectUp = CGRect(x: (self.frame.width / 2) - goal.size.width/2 + 2, y: goal.position.y + goal.frame.height/2.2, width: goal.frame.width - 4, height: 2)
        let rimPathLeft = CGPath(roundedRect: rimRectLeft, cornerWidth: 0, cornerHeight: 0, transform: nil)
        let rimPathRight = CGPath(roundedRect: rimRectRight, cornerWidth: 0, cornerHeight: 0, transform: nil)
        let rimPathUp = CGPath(roundedRect: rimRectUp, cornerWidth: 0, cornerHeight: 0, transform: nil)
        
        
        rimUp = SKShapeNode(path: rimPathUp)
        rimUp.strokeColor = UIColor.clear
        rimUp.lineWidth = 2
        rimUp.zPosition = 2
        scene?.addChild(rimUp)
        
        let rimBodyUp = SKPhysicsBody(edgeChainFrom: rimPathUp)
        rimBodyUp.categoryBitMask = PhysicsType.rim
        rimBodyUp.contactTestBitMask = PhysicsType.none
        rimBodyUp.collisionBitMask = PhysicsType.ball
        rimBodyUp.usesPreciseCollisionDetection = true
        rimUp.physicsBody = rimBodyUp
        
        rimLeft = SKShapeNode(path: rimPathLeft)
        rimLeft.strokeColor = UIColor.clear
        rimLeft.lineWidth = 2
        rimLeft.zPosition = 2
        scene?.addChild(rimLeft)
        
        let rimBodyLeft = SKPhysicsBody(edgeChainFrom: rimPathLeft)
        rimBodyLeft.categoryBitMask = PhysicsType.rim
        rimBodyLeft.contactTestBitMask = PhysicsType.keeper | PhysicsType.ball
        rimBodyLeft.collisionBitMask = PhysicsType.keeper | PhysicsType.ball
        rimBodyLeft.usesPreciseCollisionDetection = true
        rimLeft.physicsBody = rimBodyLeft
        
        rimRight = SKShapeNode(path: rimPathRight)
        rimRight.strokeColor = UIColor.clear
        rimRight.lineWidth = 2
        rimRight.zPosition = 2
        scene?.addChild(rimRight)
        
        let rimBodyRight = SKPhysicsBody(edgeChainFrom: rimPathRight)
        rimBodyRight.categoryBitMask = PhysicsType.rim
        rimBodyRight.contactTestBitMask = PhysicsType.keeper | PhysicsType.ball
        rimBodyRight.collisionBitMask = PhysicsType.keeper | PhysicsType.ball
        rimBodyRight.usesPreciseCollisionDetection = true
        rimRight.physicsBody = rimBodyRight
    }
}
