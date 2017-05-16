import SpriteKit
import UIKit
import Foundation

public class GameViewController: UIViewController  {
    
    public var gameScene: GameScene!
    var countdownTimer: Timer!
    var clockdidBegin = false
    var didRegisterBasket = false
    var currentBallindex = 0
    var pos = 0
    var kick = false
    var ok = false
    
    public override func loadView(){
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as? SKView
        gameScene = GameScene(size: CGSize(width: 1024, height: 768))
        gameScene.setupGameScene()
        gameScene.physicsWorld.contactDelegate = self
        gameScene.delegate = self
        gameScene.scaleMode = .aspectFill
        skView?.presentScene(gameScene)
        configurePanGesture()
        gameScene.createBall(currentBallindex)
        gameScene.score = 0
        clockdidBegin = false
        didRegisterBasket = false
        self.kick = false
        var sound2 = SKAction.playSoundFileNamed("torcida.mp3", waitForCompletion: true)
        self.gameScene.run(SKAction.repeatForever(sound2))
    }
    
    func configurePanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(pan)
    }
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            gameScene.hand.removeAllActions()
            gameScene.hand.removeFromParent()
            gameScene.arrow.removeAllActions()
            gameScene.arrow.removeFromParent()
            gameScene.player.isHidden = false
            if clockdidBegin == false {
                gameScene.createTimerBoard()
                clockdidBegin = true
            }
        }
        
        if recognizer.state == .ended {
            
            
            let gestureVelocity = recognizer.velocity(in: recognizer.view)
            var (xVelocity, yVelocity) = (gestureVelocity.x / 100, gestureVelocity.y / -132)
            var impulse = CGVector(dx: xVelocity * gameScene.kickPower, dy: yVelocity * gameScene.kickPower)
            if yVelocity < 0.0{
                impulse = CGVector(dx: 0, dy: 0)
            } else if yVelocity < 10{
                impulse = CGVector(dx: xVelocity * gameScene.kickPower, dy: yVelocity * 10 * gameScene.kickPower)
            } else{
                if kick == false{
                    let currentBall = gameScene.childNode(withName: "activeBall-\(currentBallindex)")
                    currentBall?.physicsBody?.applyImpulse(impulse)
                    currentBall?.physicsBody?.affectedByGravity = false
                    
                    let shadowNode = gameScene.childNode(withName: "shadow")
                    shadowNode?.removeFromParent()
                    
                    let shrinkBall = SKAction.scale(by: 0.375, duration: 0.575)
                    currentBall?.run(shrinkBall)
                    
                    let rotateBall = SKAction.rotate(byAngle: 60, duration: 3.0)
                    currentBall?.run(rotateBall)
                    
                    gameScene.run(SKAction.playSoundFileNamed("chute.wav", waitForCompletion: true))
                    
                    self.kick = true
                    self.gameScene.player.isHidden = true
                    self.gameScene.playerKick.isHidden = false
                }
            }
        }
    }
}


extension GameViewController: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let currentBall = gameScene.childNode(withName: "activeBall-\(currentBallindex)")
        currentBall?.physicsBody?.affectedByGravity = false
        
        let secondNode = contact.bodyB.node
        
        self.gameScene.player.isHidden = true
        self.gameScene.playerKick.isHidden = true
        
        if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.hoop) ||
            (contact.bodyA.categoryBitMask == PhysicsType.hoop && contact.bodyB.categoryBitMask == PhysicsType.ball) {
            if (secondNode?.physicsBody?.velocity.dy)! > CGFloat(0.0) && !didRegisterBasket {
                gameScene.run(SKAction.playSoundFileNamed("yeah.mp3", waitForCompletion: true))
                
                gameScene.score += 1
                didRegisterBasket = true
                gameScene.timer.isHidden = true
                gameScene.scoreLabel.text = "GOAAAAAAAAAAL!!!!"
                self.gameScene.playerKick.isHidden = true
                self.gameScene.playerCel.isHidden = false
                let blinkAction = SKAction.sequence([SKAction.fadeOut(withDuration: 0.1),
                                                     SKAction.fadeIn(withDuration: 0.1)])
                let blinkForTime = SKAction.repeat(blinkAction, count: 6)
                gameScene.scoreLabel.run(blinkForTime)
                
                let tex1 = SKTexture.init(imageNamed: "SoccerField_01")
                let tex2 = SKTexture.init(imageNamed: "SoccerField_02")
                let act = SKAction.animate(with: [tex1,tex2], timePerFrame: 0.1)
                let actF = SKAction.repeat(act, count: 5)
                self.gameScene.background.run(actF)
                
                currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
                currentBall?.physicsBody?.velocity.dx = 0.0
                currentBall?.physicsBody?.velocity.dy = 0.0
                currentBall?.run(blinkForTime)
                
                let respawnDelay = SKAction.wait(forDuration: 0.5)
                let respawn = SKAction.run() {
                    currentBall?.removeFromParent()
                    self.gameScene.playerCel.isHidden = true
                    self.currentBallindex += 1
                    self.gameScene.createBall(self.currentBallindex)
                    self.kick = false
                    self.gameScene.timer.isHidden = false
                    self.gameScene.scoreLabel.text = "    Goals: \(self.gameScene.score)    "
                    self.gameScene.player.isHidden = false
                }
                
                let reload = SKAction.sequence([respawnDelay, respawn])
                currentBall?.run(reload)
                didRegisterBasket = false
            }
        } else if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.edge) ||
            (contact.bodyA.categoryBitMask == PhysicsType.edge && contact.bodyB.categoryBitMask == PhysicsType.ball) {
            gameScene.run(SKAction.playSoundFileNamed("boooo.mp3", waitForCompletion: true))
            
            didRegisterBasket = true
            self.gameScene.playerKick.isHidden = true
            self.gameScene.playerBad.isHidden = false
            currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
            currentBall?.physicsBody?.velocity.dx = 0.0
            currentBall?.physicsBody?.velocity.dy = 0.0
            
            currentBall?.isHidden = true
            let respawnDelay = SKAction.wait(forDuration: 0.5)
            let respawn = SKAction.run() {
                self.gameScene.playerBad.isHidden = true
                
                let tex1 = SKTexture.init(imageNamed: "gk")
                let tex2 = SKTexture.init(imageNamed: "gk2")
                let act = SKAction.animate(with: [tex1,tex2], timePerFrame: 0.35)
                let actF = SKAction.repeatForever(act)
                self.gameScene.goalKeeper.run(actF)
                currentBall?.removeFromParent()
                self.currentBallindex += 1
                self.gameScene.createBall(self.currentBallindex)
                self.kick = false
                self.gameScene.player.isHidden = false
                
            }
            
            
            let reload = SKAction.sequence([respawnDelay, respawn])
            currentBall?.run(reload)
            didRegisterBasket = false
            
        } else if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.keeper) ||
            (contact.bodyA.categoryBitMask == PhysicsType.keeper && contact.bodyB.categoryBitMask == PhysicsType.ball) {
            
            gameScene.run(SKAction.playSoundFileNamed("boooo.mp3", waitForCompletion: true))
            
            didRegisterBasket = true
            currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
            currentBall?.physicsBody?.velocity.dx = 0.0
            currentBall?.physicsBody?.velocity.dy = 0.0
            self.gameScene.playerKick.isHidden = true
            self.gameScene.playerBad.isHidden = false
            self.gameScene.goalKeeper.texture = SKTexture(imageNamed: "gk3")
            self.gameScene.goalKeeper.removeAllActions()
            currentBall?.isHidden = true
            
            
            let respawnDelay = SKAction.wait(forDuration: 0.5)
            let respawn = SKAction.run() {
                self.gameScene.playerBad.isHidden = true
                
                let tex1 = SKTexture.init(imageNamed: "gk")
                let tex2 = SKTexture.init(imageNamed: "gk2")
                let act = SKAction.animate(with: [tex1,tex2], timePerFrame: 0.35)
                let actF = SKAction.repeatForever(act)
                self.gameScene.goalKeeper.run(actF)
                currentBall?.removeFromParent()
                self.currentBallindex += 1
                self.gameScene.createBall(self.currentBallindex)
                self.kick = false
                self.gameScene.player.isHidden = false
                
            }
            
            
            let reload = SKAction.sequence([respawnDelay, respawn])
            currentBall?.run(reload)
            didRegisterBasket = false
            
        } else if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.rim) ||
            (contact.bodyA.categoryBitMask == PhysicsType.rim && contact.bodyB.categoryBitMask == PhysicsType.ball) {
            
            gameScene.run(SKAction.playSoundFileNamed("trave.m4a", waitForCompletion: true))
            didRegisterBasket = true
            self.gameScene.playerKick.isHidden = true
            self.gameScene.playerBad.isHidden = false
            
            currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
            if (currentBall?.physicsBody?.velocity.dx)! > CGFloat(0.0) {
                currentBall?.physicsBody?.velocity.dx = 10.0
                currentBall?.physicsBody?.velocity.dy = 0.0
                
            } else{
                currentBall?.physicsBody?.velocity.dx = -10.0
                currentBall?.physicsBody?.velocity.dy = 0.0
            }
            
            currentBall?.removeAllActions()
            
            
            let respawnDelay = SKAction.wait(forDuration: 0.5)
            let respawn = SKAction.run() {
                self.gameScene.playerBad.isHidden = true
                
                currentBall?.removeFromParent()
                self.currentBallindex += 1
                self.gameScene.createBall(self.currentBallindex)
                self.kick = false
                self.gameScene.player.isHidden = false
                
            }
            
            let reload = SKAction.sequence([respawnDelay, respawn])
            currentBall?.run(reload)
            didRegisterBasket = false
        }
        
    }
}

extension GameViewController: SKSceneDelegate {
    
    
    public func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        if gameScene.kickPower < 1.0{
            gameScene.kickPower = 1.0
        }
        else if gameScene.kickPower > 10.0{
            gameScene.kickPower = 10.0
        }
        
        if gameScene.goalKeeperVelocity > 6.0{
            gameScene.kickPower = 6.0
        }
        else if gameScene.goalKeeperVelocity < 1.0{
            gameScene.goalKeeperVelocity = 1.0
        }
        
        if clockdidBegin == true{
            gameScene.timer.update()
        }
        
        
        if pos == 1{
            gameScene.goalKeeper.position.x += -gameScene.goalKeeperVelocity
            if gameScene.goalKeeper.position.x <= ((gameScene.frame.width / 2) - gameScene.goal.size.width/2 + gameScene.goalKeeper.size.width / 1.8)  {
                pos = 0
            }
        } else{
            gameScene.goalKeeper.position.x += gameScene.goalKeeperVelocity
            if gameScene.goalKeeper.position.x >= ((gameScene.frame.width / 2) + gameScene.goal.size.width/2 - gameScene.goalKeeper.size.width / 1.8) {
                pos = 1
            }
        }
        
        if self.gameScene.goalKeeperAppear{
            self.gameScene.goalKeeper.isHidden = false
        } else{
            self.gameScene.goalKeeper.isHidden = true
        }
        
        
        if gameScene.timer.hasFinished(){
            if gameScene.score >= 5 {
                self.gameScene.result.text = "YOU WIN!"
                self.gameScene.result2.text = "GO TO THE NEXT PAGE!"
                self.gameScene.ball.removeFromParent()
                self.gameScene.player.removeFromParent()
                self.gameScene.playerKick.removeFromParent()
                self.gameScene.playerBad.removeFromParent()
                self.gameScene.playerCel.isHidden = false
            }
            else{
                self.gameScene.result.text = "GAME OVER!"
                self.gameScene.result2.text = "GO TO THE NEXT PAGE!"
                self.gameScene.ball.removeFromParent()
                self.gameScene.player.removeFromParent()
                self.gameScene.playerKick.removeFromParent()
                self.gameScene.playerCel.removeFromParent()
                self.gameScene.playerBad.isHidden = false
            }
        }
    }
}
