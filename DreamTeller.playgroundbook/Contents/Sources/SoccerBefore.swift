//
//  GameViewController.swift
//  WWDC
//
//  Created by Brett Berry on 13/03/17.
//  Copyright © 2017 Pedro G. Branco. All rights reserved.
//

import UIKit
import SpriteKit

public class GameViewControllerBefore: UIViewController  {
    
    var gameScene: GameSceneBefore!
    var countdownTimer: Timer!
    var clockdidBegin = false
    var didRegisterBasket = false
    var currentBallindex = 0
    var pos = 0
    var kick = false
    
    public override func loadView(){
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        currentBallindex = 0
        let skView = view as? SKView
        gameScene = GameSceneBefore(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        gameScene.setupGameScene()
        gameScene.physicsWorld.contactDelegate = self
        gameScene.delegate = self
        skView?.presentScene(gameScene)
        configurePanGesture(ok: true)
        gameScene.createBall(currentBallindex)
        gameScene.score = 0
        clockdidBegin = false
        didRegisterBasket = false
        self.kick = false
    }
    
    func configurePanGesture(ok: Bool) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        if ok{
            view.addGestureRecognizer(pan)
        }
        else{
            view.removeGestureRecognizer(pan)
        }
    }
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            gameScene.hand.removeAllActions()
            gameScene.hand.removeFromParent()
            gameScene.arrow.removeAllActions()
            gameScene.arrow.removeFromParent()
            gameScene.player.isHidden = false
            if clockdidBegin == false {
                clockdidBegin = true
            }
        }
        
        if recognizer.state == .ended {
            
            let force: CGFloat = 1.0
            let gestureVelocity = recognizer.velocity(in: recognizer.view)
            var (xVelocity, yVelocity) = (gestureVelocity.x / 100, gestureVelocity.y / -132)
            var impulse = CGVector(dx: xVelocity * force, dy: yVelocity * force)
            if yVelocity < 0.0{
                impulse = CGVector(dx: 0, dy: 0)
            } else if yVelocity < 10{
                impulse = CGVector(dx: xVelocity * force, dy: yVelocity * 10 * force)
            } else{
                if kick == false{
                    let currentBall = gameScene.childNode(withName: "activeBall-\(currentBallindex)")
                    currentBall?.physicsBody?.applyImpulse(impulse)
                    currentBall?.physicsBody?.affectedByGravity = false
                    
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


extension GameViewControllerBefore: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let currentBall = gameScene.childNode(withName: "activeBall-\(currentBallindex)")
        currentBall?.physicsBody?.affectedByGravity = false
        
        let secondNode = contact.bodyB.node
        
        self.gameScene.player.isHidden = true
        self.gameScene.playerKick.isHidden = true
        
        if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.hoop) ||
            (contact.bodyA.categoryBitMask == PhysicsType.hoop && contact.bodyB.categoryBitMask == PhysicsType.ball) {
            if (secondNode?.physicsBody?.velocity.dy)! > CGFloat(0.0) && !didRegisterBasket {
                gameScene.score += 1
                didRegisterBasket = true
                gameScene.timer.isHidden = true
                self.gameScene.playerKick.isHidden = true
                self.gameScene.playerCel.isHidden = false
                
                currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
                currentBall?.physicsBody?.velocity.dx = 0.0
                currentBall?.physicsBody?.velocity.dy = 0.0
                
                let respawnDelay = SKAction.wait(forDuration: 0.5)
                let respawn = SKAction.run() {
                    currentBall?.removeFromParent()
                    self.gameScene.playerCel.isHidden = true
                    self.currentBallindex += 1
                    self.gameScene.createBall(self.currentBallindex)
                    self.kick = false
                    self.gameScene.player.isHidden = false
                }
                
                let reload = SKAction.sequence([respawnDelay, respawn])
                currentBall?.run(reload)
                didRegisterBasket = false
            }
        } else if (contact.bodyA.categoryBitMask == PhysicsType.ball && contact.bodyB.categoryBitMask == PhysicsType.edge) ||
            (contact.bodyA.categoryBitMask == PhysicsType.edge && contact.bodyB.categoryBitMask == PhysicsType.ball) {
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
            didRegisterBasket = true
            currentBall?.physicsBody?.categoryBitMask = PhysicsType.none
            currentBall?.physicsBody?.velocity.dx = 0.0
            currentBall?.physicsBody?.velocity.dy = 0.0
            self.gameScene.playerKick.isHidden = true
            self.gameScene.playerBad.isHidden = false
            
            currentBall?.isHidden = true
            
            
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


extension GameViewControllerBefore: SKSceneDelegate {
    
    public func update(_ currentTime: TimeInterval, for scene: SKScene) {
        let tex2 = SKTexture.init(imageNamed: "SoccerField_02")
        
        gameScene.background = SKSpriteNode(texture: tex2, size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        
        if currentBallindex >= 3{
            self.gameScene.ball.removeFromParent()
            self.gameScene.hand.removeFromParent()
            self.gameScene.arrow.removeFromParent()
            self.gameScene.player.removeFromParent()
            self.gameScene.playerBad.removeFromParent()
            self.gameScene.playerCel.removeFromParent()
            self.gameScene.playerKick.removeFromParent()
            self.configurePanGesture(ok: false)
            
        }
    }
}
