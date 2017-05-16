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

public class Lisa: SKScene{
    
    var background: SKSpriteNode!
    var lisa: SKSpriteNode!
    var text: SKLabelNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var baloon: SKSpriteNode!
    var pedrinho: SKSpriteNode!
    var poof: SKSpriteNode!
    var think: SKSpriteNode!
    var canShake = false
    var pedroTouch = false
    let motionManager = CMMotionManager()
    
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        
        motionManager.startAccelerometerUpdates()
        
        self.background = SKSpriteNode(imageNamed: "fundo2")
        self.background.size = self.frame.size
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.zPosition = 0
        self.addChild(self.background)
        
        
        self.lisa = SKSpriteNode(imageNamed: "lisa2")
        self.lisa.position = CGPoint(x: 0, y: self.frame.midY - self.frame.midY/2.50)
        self.lisa.zPosition = 1
        self.lisa.setScale(0.25)
        self.addChild(lisa)
        
        self.pedrinho = SKSpriteNode(imageNamed: "MiniMe_01")
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.25)
        
        self.poof = SKSpriteNode(imageNamed: "tap")
        self.poof.zPosition = 1
        self.poof.setScale(0.25)
        
        self.baloon = SKSpriteNode(imageNamed: "baloon")
        self.baloon.position = CGPoint(x: self.frame.midX - 20, y: self.frame.midY + 45)
        self.baloon.zPosition = 1
        self.baloon.setScale(0.45)
        
        self.think = SKSpriteNode(imageNamed: "docs")
        self.think.position = CGPoint(x: self.frame.midX + self.baloon.frame.width/1.45, y: self.frame.midY)
        self.think.zPosition = 1
        self.think.setScale(0.2)
        
        self.text = SKLabelNode()
        self.text.fontColor = .black
        self.text.position = CGPoint(x: 22, y: self.baloon.frame.height/1.5)
        self.text.fontSize = 35
        self.text.fontName = "ChalkboardSE-Bold"
        
        self.text1 = SKLabelNode()
        self.text1.fontColor = .black
        self.text1.position = CGPoint(x: 10, y: self.text.position.y - 50)
        self.text1.fontSize = 35
        self.text1.fontName = "ChalkboardSE-Bold"
        
        self.text2 = SKLabelNode()
        self.text2.fontColor = .black
        self.text2.position = CGPoint(x: 10, y: self.text1.position.y - 50)
        self.text2.fontSize = 35
        self.text2.fontName = "ChalkboardSE-Bold"
        
        self.text3 = SKLabelNode()
        self.text3.fontColor = .black
        self.text3.position = CGPoint(x: 10, y: self.text2.position.y - 50)
        self.text3.fontSize = 35
        self.text3.fontName = "ChalkboardSE-Bold"
        
        self.text4 = SKLabelNode()
        self.text4.fontColor = .black
        self.text4.position = CGPoint(x: 10, y: self.text3.position.y - 50)
        self.text4.fontSize = 35
        self.text4.fontName = "ChalkboardSE-Bold"
        
        
        animateLisa()
    }
    
    func animateLisa(){
        
        let moveX = SKAction.moveBy(x: self.frame.midX/4, y: 0, duration: 0.25)
        let change4 = SKAction.animate(with: [SKTexture.init(imageNamed: "lisa4")], timePerFrame: 0.1)
        let change5 = SKAction.animate(with: [SKTexture.init(imageNamed: "lisa5")], timePerFrame: 0.1)
        let change6 = SKAction.animate(with: [SKTexture.init(imageNamed: "lisa6")], timePerFrame: 0.1)
        
        let group1 = SKAction.group([moveX, change4])
        let group2 = SKAction.group([moveX, change5])
        let group3 = SKAction.group([moveX, change6])
        
        let animate = SKAction.sequence([group1, group2, group3])
        
        self.lisa.run(animate){
            
            self.fillText()
            let animate = SKAction.animate(with: [SKTexture.init(imageNamed: "lisa1"), SKTexture.init(imageNamed: "lisa9"), SKTexture.init(imageNamed: "lisa1") , SKTexture.init(imageNamed: "lisa2")], timePerFrame: 0.25)
            let again = SKAction.repeat(animate, count: 2)
            self.lisa.run(again)
            
            let wait = SKAction.wait(forDuration: 0.5)
            self.run(wait){
                self.fillText1()
            }
            
            let wait2 = SKAction.wait(forDuration: 1)
            self.run(wait2){
                self.fillText2()
            }
            
            let wait3 = SKAction.wait(forDuration: 2)
            self.run(wait3){
                self.clearText()
                baloon2()
            }
            
            func baloon2(){
                
                self.fillText21()
                
                let again = SKAction.repeat(animate, count: 2)
                self.lisa.run(again)
                
                let wait = SKAction.wait(forDuration: 0.5)
                self.run(wait){
                    self.fillText22()
                }
                let wait2 = SKAction.wait(forDuration: 1)
                self.run(wait2){
                    self.fillText23()
                }
                let wait4 = SKAction.wait(forDuration: 2)
                self.run(wait4){
                    self.clearText()
                    baloon3()
                }
            }
            
            func baloon3(){
                
                self.fillText31()
                
                let again = SKAction.repeat(animate, count: 4)
                self.lisa.run(again)
                
                let wait = SKAction.wait(forDuration: 0.5)
                self.run(wait){
                    self.fillText32()
                }
                let wait2 = SKAction.wait(forDuration: 1)
                self.run(wait2){
                    self.fillText33()
                }
                let wait3 = SKAction.wait(forDuration: 1.5)
                self.run(wait3){
                    self.fillText34()
                }
                let wait5 = SKAction.wait(forDuration: 2.5)
                self.run(wait5){
                    self.clearText()
                    self.showPedro()
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
    
    func showPedro(){
        self.baloon.isHidden = false
        
        let wait6 = SKAction.wait(forDuration: 0.35)
        self.run(wait6){
            
            self.fillText51()
            let wait6 = SKAction.wait(forDuration: 0.35)
            self.run(wait6){
                self.fillText52()
                let scaleUp = SKAction.scale(to: 1.3, duration: 0.3)
                let scaleDown = SKAction.scale(to: 1, duration: 0.3)
                let sqc = SKAction.sequence([scaleUp, scaleDown])
                self.text2.run(SKAction.repeatForever(sqc))
                self.canShake = true
            }
        }
        
    }
    
    // ----------------------------------------- SHAKE LISA FALL -------------------------//
    
    func shake(){
        self.text2.removeAllActions()
        self.text2.setScale(1)
        self.baloon.isHidden = true
        
        self.pedrinho.position.y = self.frame.height*2
        self.pedrinho.position.x = self.frame.width/2 + self.lisa.size.width
        
        self.poof.position = self.pedrinho.position
        
        self.addChild(self.poof)
        
        let move = SKAction.move(to: CGPoint.init(x: self.frame.width/2 + self.lisa.size.width, y: self.frame.midY - self.frame.midY/2.50), duration: 2)
        let rotate = SKAction.rotate(toAngle: 12.5664, duration: 2)
        let agroup = SKAction.group([move, rotate])
        
        self.poof.run(agroup){
            
            let scaleUp = SKAction.scale(to: 0.3, duration: 0.3)
            let scaleDown = SKAction.scale(to: 0.25, duration: 0.3)
            let sqc = SKAction.sequence([scaleUp, scaleDown])
            
            self.poof.run(SKAction.repeatForever(sqc))
            self.pedroTouch = true
        }
    }
    
    func pedrinhoKid(){
        
        self.clearText()
        
        self.pedrinho.position.x = self.frame.width/2
        
        let reading = SKAction.animate(with: [SKTexture.init(imageNamed: "miniMeBook"), SKTexture.init(imageNamed: "pedrinhoread"), SKTexture.init(imageNamed: "pblinkread")], timePerFrame: 0.3)
        
        let kick = SKAction.animate(with: [SKTexture.init(imageNamed: "pkick"), SKTexture.init(imageNamed: "pkick2"), SKTexture.init(imageNamed: "pkick"), SKTexture.init(imageNamed: "pkick2")], timePerFrame: 0.3)
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "pkick")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.50
        self.pedrinho.position.x = self.frame.width/2 + self.lisa.size.width
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.25)
        self.addChild(self.pedrinho)
        
        let timer = SKAction.repeat(kick, count: 1)
        
        self.pedrinho.run(timer){
            
            self.pedrinho.run(fadeOut){
                self.pedrinho.removeFromParent()
                self.pedrinho = SKSpriteNode(imageNamed: "miniMeBook")
                self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.50
                self.pedrinho.position.x = self.frame.width/2 + self.lisa.size.width
                self.pedrinho.zPosition = 1
                self.pedrinho.setScale(0.25)
                self.addChild(self.pedrinho)
                
                let timer2 = SKAction.repeat(reading, count: 1)
                self.pedrinho.run(timer2){
                    self.pedroTalk()
                }
            }
        }
    }
    
    func pedroTalk(){
        
        let reading = SKAction.animate(with: [SKTexture.init(imageNamed: "MiniMe_01"), SKTexture.init(imageNamed: "pedrinhoread"), SKTexture.init(imageNamed: "pblink")], timePerFrame: 0.2)
        self.pedrinho.run(SKAction.repeatForever(reading))
        
        self.clearText()
        self.baloon.isHidden = false
        
        self.fillText61()
        let animate = SKAction.animate(with: [SKTexture.init(imageNamed: "lisa1"), SKTexture.init(imageNamed: "lisa9"), SKTexture.init(imageNamed: "lisa1") , SKTexture.init(imageNamed: "lisa2")], timePerFrame: 0.25)
        let again = SKAction.repeat(animate, count: 2)
        self.lisa.run(again)
        
        let wait = SKAction.wait(forDuration: 0.8)
        self.run(wait){
            self.fillText62()
        }
        
        let wait2 = SKAction.wait(forDuration: 1.6)
        self.run(wait2){
            self.fillText63()
        }
        
        let wait3 = SKAction.wait(forDuration: 2.4)
        self.run(wait3){
            self.fillText64()
            self.run(wait2){
                self.clearText()
                baloon2()
            }
        }
        
        func baloon2(){
            
            self.fillText71()
            
            let again = SKAction.repeat(animate, count: 2)
            self.lisa.run(again)
            
            let wait = SKAction.wait(forDuration: 0.8)
            self.run(wait){
                self.fillText72()
            }
            let wait2 = SKAction.wait(forDuration: 1.6)
            self.run(wait2){
                self.fillText73()
            }
            let wait3 = SKAction.wait(forDuration: 2.4)
            self.run(wait3){
                self.fillText74()
            }
            let wait4 = SKAction.wait(forDuration: 3.2)
            self.run(wait4){
                self.fillText75()
            }
            let wait5 = SKAction.wait(forDuration: 4)
            self.run(wait5){
                self.clearText()
                baloon3()
            }
        }
        
        func baloon3(){
            
            self.fillText81()
            
            let again = SKAction.repeat(animate, count: 2)
            self.lisa.run(again)
            
            let wait = SKAction.wait(forDuration: 0.8)
            self.run(wait){
                self.fillText82()
            }
            let wait2 = SKAction.wait(forDuration: 1.5)
            self.run(wait2){
                self.fillText83()
            }
            let wait3 = SKAction.wait(forDuration: 2.4)
            self.run(wait3){
                self.fillText84()
            }
            let wait4 = SKAction.wait(forDuration: 3.2)
            self.run(wait4){
                self.fillText85()
            }
            let wait5 = SKAction.wait(forDuration: 4)
            self.run(wait5){
                self.clearText()
                self.fillText91()
            }
            let wait6 = SKAction.wait(forDuration: 5)
            self.run(wait6){
                self.fillText92()
                let scaleUp = SKAction.scale(to: 1.3, duration: 0.3)
                let scaleDown = SKAction.scale(to: 1, duration: 0.3)
                let sqc = SKAction.sequence([scaleUp, scaleDown])
                self.text2.run(SKAction.repeatForever(sqc))
            }
        }
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "MiniMe_01")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/2.50
        self.pedrinho.position.x = self.frame.width/2 + self.lisa.size.width
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.25)
        self.addChild(self.pedrinho)
        
        let reading1 = SKAction.animate(with: [SKTexture.init(imageNamed: "MiniMe_01"), SKTexture.init(imageNamed: "pblink")], timePerFrame: 0.2)
        self.pedrinho.run(SKAction.repeatForever(reading1))
        
        let wait33 = SKAction.wait(forDuration: 3)
        self.run(wait33){
            self.addChild(self.think)
            let wait2 = SKAction.wait(forDuration: 3.5)
            self.run(wait2){
                self.think.removeFromParent()
                let wait4 = SKAction.wait(forDuration: 2.65)
                self.run(wait4){
                    self.think = SKSpriteNode(imageNamed: "think hero")
                    self.think.position = CGPoint(x: self.frame.midX + self.baloon.frame.width/1.45, y: self.frame.midY)
                    self.think.zPosition = 1
                    self.think.setScale(0.2)
                    self.addChild(self.think)
                    self.pedrinho.removeAllActions()
                }
            }
        }
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
        self.text1.animate(newText: "Hi, I’m L1-S4.", characterDelay: 0.1)
    }
    
    func fillText1(){
        self.text2.animate(newText: "A dream teller", characterDelay: 0.1)
    }
    
    func fillText2(){
        self.text3.animate(newText: "robot...", characterDelay: 0.1)
    }
    
    
    // ----------------Baloon 2---------------- //
    
    
    func fillText21(){
        self.text1.animate(newText: "Today we will", characterDelay: 0.1)
    }
    
    func fillText22(){
        self.text2.animate(newText: "do something", characterDelay: 0.1)
    }
    
    func fillText23(){
        self.text3.animate(newText: "special ...", characterDelay: 0.1)
    }
    
    
    // ----------------Baloon 3---------------- //
    
    
    func fillText31(){
        self.text.animate(newText: "We will help", characterDelay: 0.1)
    }
    
    func fillText32(){
        self.text1.animate(newText: "a little boy", characterDelay: 0.1)
    }
    
    func fillText33(){
        self.text2.animate(newText: "to realize his", characterDelay: 0.1)
    }
    
    func fillText34(){
        self.text3.animate(newText: "biggest dream.", characterDelay: 0.1)
    }
    
    // ----------------Baloon 5---------------- //
    
    
    func fillText51(){
        self.text1.animate(newText: "To start, please", characterDelay: 0.1)
    }
    func fillText52(){
        self.text2.animate(newText: "SHAKE THE DEVICE", characterDelay: 0.1)
    }
    
    func fillText61(){
        self.text.animate(newText: "This is Pedro", characterDelay: 0.1)
    }
    func fillText62(){
        self.text1.animate(newText: "a kid who dreams", characterDelay: 0.1)
    }
    func fillText63(){
        self.text2.animate(newText: "about change and", characterDelay: 0.1)
    }
    func fillText64(){
        self.text3.animate(newText: "impact the world...", characterDelay: 0.1)
    }
    
    func fillText71(){
        self.text.animate(newText: "Inspired by his", characterDelay: 0.1)
    }
    func fillText72(){
        self.text1.animate(newText: "parents who are", characterDelay: 0.1)
    }
    func fillText73(){
        self.text2.animate(newText: "doctors and make the", characterDelay: 0.1)
    }
    func fillText74(){
        self.text3.animate(newText: "difference saving", characterDelay: 0.1)
    }
    func fillText75(){
        self.text4.animate(newText: "peolple's lives.", characterDelay: 0.1)
    }
    
    func fillText81(){
        self.text.animate(newText: "But Pedro wants", characterDelay: 0.1)
    }
    func fillText82(){
        self.text1.animate(newText: "to do different.", characterDelay: 0.1)
    }
    func fillText83(){
        self.text2.animate(newText: "He will make the", characterDelay: 0.1)
    }
    func fillText84(){
        self.text3.animate(newText: "difference being", characterDelay: 0.1)
    }
    func fillText85(){
        self.text4.animate(newText: "a SUPER HERO!", characterDelay: 0.1)
    }
    
    func fillText91(){
        self.text1.animate(newText: "To help him go", characterDelay: 0.1)
    }
    func fillText92(){
        self.text2.animate(newText: "to the NEXT PAGE", characterDelay: 0.1)
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began touched")
        let touch: UITouch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if self.poof.contains(touchLocation) && pedroTouch == true {
            print("touched poof")
            
            self.run(SKAction.wait(forDuration: 0.5)){
                self.poof.removeFromParent()
                self.addChild(self.pedrinho)
                self.pedrinhoKid()
                self.pedroTouch = false
            }
        }
    }
    
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        
        if let data = motionManager.accelerometerData {
            if (fabs(data.acceleration.x) > 1.5 || fabs(data.acceleration.y) > 1.5 || fabs(data.acceleration.y) < -1.5 || fabs(data.acceleration.x) < -1.5 || fabs(data.acceleration.z) > 1.5 || fabs(data.acceleration.z) < -1.5) && canShake == true{
                print("AccelerationX: \(data.acceleration.x)")
                print("AccelerationY: \(data.acceleration.y)")
                print("AccelerationZ: \(data.acceleration.z)")
                canShake = false
                
                shake()
            }
        }
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        processUserMotion(forUpdate: currentTime)
    }
    
}

extension SKLabelNode {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.characters.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay/2 * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
}
