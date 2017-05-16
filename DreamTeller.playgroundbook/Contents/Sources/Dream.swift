//
//  Lisa.swift
//  L1-S4
//
//  Created by Pedro Gomes Branco on 29/03/17.
//  Copyright © 2017 Pedro Gomes Branco. All rights reserved.
//

import CoreMotion
import SpriteKit
import GameplayKit

public class Dream: SKScene {
    
    var background: SKSpriteNode!
    var lisa: SKSpriteNode!
    var text: SKLabelNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var baloon: SKSpriteNode!
    var pedrinho: SKSpriteNode!
    var think: SKSpriteNode!
    var superHero: SKSpriteNode!
    var r10: SKSpriteNode!
    var jobs: SKSpriteNode!
    
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        self.background = SKSpriteNode(imageNamed: "fundo2")
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.size = self.frame.size
        self.background.zPosition = 0
        self.addChild(self.background)
        
        
        self.lisa = SKSpriteNode(imageNamed: "lisa2")
        self.lisa.position = CGPoint(x: 0, y: self.frame.height - self.lisa.frame.height/4)
        self.lisa.zPosition = 1
        self.lisa.setScale(0.5)
        
        
        self.pedrinho = SKSpriteNode(imageNamed: "pedrinhoread")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
        self.pedrinho.position.x = self.frame.width/2
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.5)
        
        self.baloon = SKSpriteNode(imageNamed: "baloon2")
        self.baloon.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.midY/2)
        self.baloon.zPosition = 1
        self.baloon.setScale(0.85)
        
        self.think = SKSpriteNode(imageNamed: "think hero")
        self.think.position = CGPoint(x: self.frame.midX + self.frame.midX/4, y: self.frame.midY + self.frame.midY/2.5)
        self.think.zPosition = 1
        self.think.setScale(0.55)
        
        self.superHero = SKSpriteNode(imageNamed: "hero copy")
        self.superHero.position = CGPoint(x: self.frame.midX/2 , y: self.frame.midY + self.frame.midY/4)
        self.superHero.zPosition = 1
        self.superHero.setScale(0.25)
        
        self.r10 = SKSpriteNode(imageNamed: "r10")
        self.r10.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.midY/4)
        self.r10.zPosition = 1
        self.r10.setScale(0.35)
        
        self.jobs = SKSpriteNode(imageNamed: "steve")
        self.jobs.position = CGPoint(x: self.frame.midX + self.frame.midX/2, y: self.frame.midY + self.frame.midY/4)
        self.jobs.zPosition = 1
        self.jobs.setScale(0.25)
        
        self.text = SKLabelNode()
        self.text.fontColor = .black
        self.text.position = CGPoint(x: 22, y: self.baloon.frame.height/3.1)
        self.text.fontSize = 40
        self.text.fontName = "ChalkboardSE-Bold"
        
        self.text1 = SKLabelNode()
        self.text1.fontColor = .black
        self.text1.position = CGPoint(x: 10, y: self.text.position.y - 50)
        self.text1.fontSize = 40
        self.text1.fontName = "ChalkboardSE-Bold"
        
        self.text2 = SKLabelNode()
        self.text2.fontColor = .black
        self.text2.position = CGPoint(x: 10, y: self.text1.position.y - 50)
        self.text2.fontSize = 40
        self.text2.fontName = "ChalkboardSE-Bold"
        
        self.text3 = SKLabelNode()
        self.text3.fontColor = .black
        self.text3.position = CGPoint(x: 10, y: self.text2.position.y - 50)
        self.text3.fontSize = 40
        self.text3.fontName = "ChalkboardSE-Bold"
        
        self.text4 = SKLabelNode()
        self.text4.fontColor = .black
        self.text4.position = CGPoint(x: 10, y: self.text3.position.y - 50)
        self.text4.fontSize = 40
        self.text4.fontName = "ChalkboardSE-Bold"
        
        wakeUp()
    }
    
    func wakeUp(){
        self.addChild(pedrinho)
        self.addChild(think)
        let rotate1 = SKAction.rotate(toAngle: 5.4, duration: 0.00001)
        self.addChild(lisa)
        self.lisa.isHidden = true
        self.lisa.run(rotate1){
            self.lisa.isHidden = false
        }
        
        self.run(SKAction.wait(forDuration: 1)){
            self.think.removeFromParent()
            
            self.fillText()
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)

            
            let wait = SKAction.wait(forDuration: 1)
            self.run(wait){
                self.fillText1()
            }
            
            let wait2 = SKAction.wait(forDuration: 1.9)
            self.run(wait2){
                self.fillText2()
            }
            
            let wait3 = SKAction.wait(forDuration: 3)
            self.run(wait3){
                self.clearText()
                self.pedrinho.removeFromParent()
                self.pedrinho = SKSpriteNode(imageNamed: "miniMeBook")
                self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
                self.pedrinho.position.x = self.frame.width/2
                self.pedrinho.zPosition = 1
                self.pedrinho.setScale(0.5)
                self.addChild(self.pedrinho)
            }
            
            let wait23 = SKAction.wait(forDuration: 3.6)
            self.run(wait23){
                self.fillText21()
            }
            
            let wait22 = SKAction.wait(forDuration: 4.6)
            self.run(wait22){
                self.fillText22()
            }
            
            let wait32 = SKAction.wait(forDuration: 5.2)
            self.run(wait32){
                self.clearText()
                self.baloon.isHidden = true
                self.pedrinho.run(fadeOut){
                    self.pedrinho.removeFromParent()
                    self.pedrinho = SKSpriteNode(imageNamed: "MiniMe_01")
                    self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
                    self.pedrinho.position.x = self.frame.width/2
                    self.pedrinho.zPosition = 1
                    self.pedrinho.setScale(0.5)
                    self.addChild(self.pedrinho)
                    let change = SKAction.animate(with: [SKTexture.init(imageNamed: "MiniMe_02"), SKTexture.init(imageNamed: "MiniMe_01")], timePerFrame: 0.3)
                    let doagain = SKAction.repeat(change, count: 5)
                    self.pedrinho.run(doagain){
                        self.quadros1()
                    }
                }
            }
            
            
            self.baloon.addChild(self.text)
            self.baloon.addChild(self.text1)
            self.baloon.addChild(self.text2)
            self.baloon.addChild(self.text3)
            self.baloon.addChild(self.text4)
            self.addChild(self.baloon)
        }
        
    }
    
    func quadros1(){
        self.baloon.isHidden = false
        
        self.fillText31()
        
        let wait = SKAction.wait(forDuration: 1.2)
        self.run(wait){
            self.fillText32()
            let talk = SKAction.animate(with: [SKTexture.init(imageNamed: "plook")], timePerFrame: 3)
            let ok = SKAction.repeat(talk, count: 1)
            self.pedrinho.run(ok)
        }
        let wait2 = SKAction.wait(forDuration: 2.2)
        self.run(wait2){
            self.fillText33()
        }
        let wait3 = SKAction.wait(forDuration: 3.5)
        self.run(wait3){
            self.fillText34()
            self.pedrinho.removeFromParent()
            self.pedrinho = SKSpriteNode(imageNamed: "pidea")
            self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
            self.pedrinho.position.x = self.frame.width/2
            self.pedrinho.zPosition = 1
            self.pedrinho.setScale(0.5)
            self.addChild(self.pedrinho)

        }
        
        let wait5 = SKAction.wait(forDuration: 6)
        self.run(wait5){
            self.clearText()
            self.quadros()
        }
    }
    
    func quadros() {
        self.baloon.isHidden = true
        
        self.addChild(jobs)
        self.addChild(r10)
        self.addChild(superHero)
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "MiniMe_01")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
        self.pedrinho.position.x = self.frame.width/2
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.5)
        self.addChild(self.pedrinho)
        
        let talk = SKAction.animate(with: [SKTexture.init(imageNamed: "MiniMe_01"), SKTexture.init(imageNamed: "pedrinhorindoblink")], timePerFrame: 0.2)
        
        let again = SKAction.repeat(talk, count: 21)
        
        self.pedrinho.run(again){
            self.quadros2()
        }
        
    }
    
    func quadros2(){
        self.r10.removeFromParent()
        self.jobs.removeFromParent()
        self.superHero.removeFromParent()
        self.baloon.isHidden = false
        
        self.fillText41()
        
        let wait = SKAction.wait(forDuration: 0.85)
        self.run(wait){
            self.fillText42()
        }
        let wait2 = SKAction.wait(forDuration: 1.65)
        self.run(wait2){
            self.fillText43()
        }
        let wait5 = SKAction.wait(forDuration: 2.4)
        self.run(wait5){
            self.clearText()
            self.roupaBR()
        }
    }
    
    func roupaBR(){
        self.baloon.isHidden = true
        let rotate = SKAction.scale(to: 0, duration: 1)
        self.pedrinho.run(rotate)
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "pbr")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.55
        self.pedrinho.position.x = self.frame.width/2
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.0)
        self.addChild(self.pedrinho)
        
        let rotate1 = SKAction.scale(to: 0.5, duration: 1)
        self.pedrinho.run(rotate1)
    }
    
    
    func clearText(){
        self.text.text = ""
        self.text1.text = ""
        self.text2.text = ""
        self.text3.text = ""
        self.text4.text = ""
    }
    
    // ----------------Baloon 1---------------- //
    
    func fillText(){
        self.text1.animate(newText: "PEDRO!", characterDelay: 0.1)
    }
    
    func fillText1(){
        self.text2.animate(newText: "PEDRO!!", characterDelay: 0.1)
    }
    
    func fillText2(){
        self.text3.animate(newText: "WAKE UP!!", characterDelay: 0.1)
    }
    
    
    // ----------------Baloon 2---------------- //
    
    
    func fillText21(){
        self.text1.animate(newText: "IT WAS JUST", characterDelay: 0.1)
    }
    
    func fillText22(){
        self.text2.animate(newText: "A DREAM...", characterDelay: 0.1)
    }
    
    
    // ----------------Baloon 3---------------- //
    
    
    func fillText31(){
        self.text.animate(newText: "PEDRO, LOOK TO", characterDelay: 0.1)
    }
    
    func fillText32(){
        self.text1.animate(newText: "YOUR IDOLS AND", characterDelay: 0.1)
    }
    
    func fillText33(){
        self.text2.animate(newText: "THINK ABOUT WHAT", characterDelay: 0.1)
    }
    
    func fillText34(){
        self.text3.animate(newText: "THEY HAVE DONE...", characterDelay: 0.1)
    }
    
    
    // ----------------Baloon 4---------------- //
    
    
    
    
    func fillText41(){
        self.text1.animate(newText: "SO, YOU WANNA BE", characterDelay: 0.1)
    }
    
    func fillText42(){
        self.text2.animate(newText: "A SOCCER STAR, ", characterDelay: 0.1)
    }
    
    func fillText43(){
        self.text3.animate(newText: "RIGHT?!", characterDelay: 0.1)
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
