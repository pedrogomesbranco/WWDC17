import CoreMotion
import SpriteKit
import GameplayKit

public class Pedro: SKScene {
    
    var background: SKSpriteNode!
    var lisa: SKSpriteNode!
    var pedrinho: SKSpriteNode!
    var baloon: SKSpriteNode!
    var baloon2: SKSpriteNode!
    let cameraNode = SKCameraNode()
    var text: SKLabelNode!
    var textao: SKLabelNode!
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var text3: SKLabelNode!
    var text4: SKLabelNode!
    var message: SKLabelNode!
    var texto: SKLabelNode!
    public var called = false
    
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        self.run(SKAction.playSoundFileNamed("intro.mp3", waitForCompletion: false))
        
        self.background = SKSpriteNode(imageNamed: "fundo2")
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.size = self.frame.size
        self.background.zPosition = 0
        self.addChild(self.background)
        
        self.baloon = SKSpriteNode(imageNamed: "baloon")
        self.baloon.position = CGPoint(x: self.frame.midX + 35, y: self.frame.midY + self.frame.midY/2)
        self.baloon.zPosition = 1
        self.baloon.setScale(0.45)
        
        self.baloon2 = SKSpriteNode(imageNamed: "baloon")
        self.baloon2.position = CGPoint(x: self.frame.midX + self.frame.midX/3, y: self.frame.midY )
        self.baloon2.zPosition = 1
        self.baloon2.setScale(0.15)
        
        self.lisa = SKSpriteNode(imageNamed: "lisa2")
        self.lisa.position = CGPoint(x: 0, y: self.frame.height - self.lisa.frame.height/4)
        self.lisa.zPosition = 1
        self.lisa.setScale(0.5)
        
        cameraNode.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height / 2)
        scene?.addChild(cameraNode)
        scene?.camera = cameraNode
        
        go()
        
        self.run(SKAction.wait(forDuration: 0.2)){
            self.pedrinho = SKSpriteNode(imageNamed: "pedrao")
            self.pedrinho.position.y = self.frame.midY - self.frame.midY/3
            self.pedrinho.position.x = self.frame.width/2 - 50
            self.pedrinho.zPosition = 1
            self.pedrinho.setScale(0.5)
            self.addChild(self.pedrinho)
        }
        
        self.text = SKLabelNode()
        self.text.fontColor = .black
        self.text.position = CGPoint(x: 22, y: self.baloon.frame.height/2)
        self.text.fontSize = 40
        self.text.fontName = "ChalkboardSE-Bold"
        
        self.text1 = SKLabelNode()
        self.text1.fontColor = .black
        self.text1.position = CGPoint(x: 10, y: self.text.position.y - 40)
        self.text1.fontSize = 40
        self.text1.fontName = "ChalkboardSE-Bold"
        
        self.texto = SKLabelNode()
        self.texto.fontColor = .black
        self.texto.position = CGPoint(x: self.baloon2.frame.width/2, y: self.baloon2.frame.height/2)
        self.texto.fontSize = 40
        self.texto.fontName = "ChalkboardSE-Bold"
        
        self.text2 = SKLabelNode()
        self.text2.fontColor = .black
        self.text2.position = CGPoint(x: 10, y: self.text1.position.y - 40)
        self.text2.fontSize = 40
        self.text2.fontName = "ChalkboardSE-Bold"
        
        self.text3 = SKLabelNode()
        self.text3.fontColor = .black
        self.text3.position = CGPoint(x: 10, y: self.text2.position.y - 40)
        self.text3.fontSize = 40
        self.text3.fontName = "ChalkboardSE-Bold"
        
        self.text4 = SKLabelNode()
        self.text4.fontColor = .black
        self.text4.position = CGPoint(x: 10, y: self.text2.position.y - 40)
        self.text4.fontSize = 40
        self.text4.fontName = "ChalkboardSE-Bold"
        
    }
    
    func go(){
        let zoomInAction = SKAction.scale(to: 0.03, duration: 0.0001)
        let zoomOut = SKAction.scale(to: 1, duration: 6.5)
        
        cameraNode.run(zoomInAction){
            self.cameraNode.run(zoomOut){
                self.baloon.addChild(self.text)
                self.baloon.addChild(self.text1)
                self.baloon.addChild(self.text2)
                self.baloon.addChild(self.text3)
                self.baloon.addChild(self.text4)
                self.addChild(self.baloon)
                self.talk()
            }
        }
    }
    
    func talk(){
        
        let animation = SKAction.animate(with: [SKTexture.init(imageNamed: "pedrao"), SKTexture.init(imageNamed: "pedrao 11")], timePerFrame: 0.3)
        let repetition = SKAction.repeat(animation, count: 3)
        
        let animation2 = SKAction.animate(with: [SKTexture.init(imageNamed: "pedrao all code"), SKTexture.init(imageNamed: "pedrao all code talk")], timePerFrame: 0.3)
        
        let repetition2 = SKAction.repeat(animation2, count: 20)
        
        let sequencia = SKAction.sequence([repetition, repetition2])
        
        self.pedrinho.run(sequencia)
        
        self.fillText()
        
        let wait = SKAction.wait(forDuration: 1)
        self.run(wait){
            self.fillText1()
        }
        
        let wait2 = SKAction.wait(forDuration: 2)
        self.run(wait2){
            self.fillText2()
        }
        
        let wait3 = SKAction.wait(forDuration: 4)
        self.run(wait3){
            self.clearText()
            self.fillText11()
        }
        
        let wait5 = SKAction.wait(forDuration: 5)
        self.run(wait5){
            self.fillText12()
        }
        
        let wait6 = SKAction.wait(forDuration: 6)
        self.run(wait6){
            self.fillText13()
        }
        let wait7 = SKAction.wait(forDuration: 7)
        self.run(wait7){
            self.clearText()
            self.fillText14()
        }
        let wait9 = SKAction.wait(forDuration: 8)
        self.run(wait9){
            self.fillText15()
        }
        let wait8 = SKAction.wait(forDuration: 9)
        self.run(wait8){
            self.fillText16()
        }
        let wait10 = SKAction.wait(forDuration: 10)
        self.run(wait10){
            self.fillText17()
        }
        let wait11 = SKAction.wait(forDuration: 11)
        self.run(wait11){
            self.clearText()
            self.fillText21()
        }
        let wait12 = SKAction.wait(forDuration: 12)
        self.run(wait12){
            self.fillText22()
        }
        let wait13 = SKAction.wait(forDuration: 13)
        self.run(wait13){
            self.fillText23()
        }
        let wait14 = SKAction.wait(forDuration: 14)
        self.run(wait14){
            self.clearText()
            self.fillText24()
        }
        let wait15 = SKAction.wait(forDuration: 15)
        self.run(wait15){
            self.fillText25()
        }
        let wait16 = SKAction.wait(forDuration: 16)
        self.run(wait16){
            self.fillText26()
        }
        let wait17 = SKAction.wait(forDuration: 19)
        self.run(wait17){
            self.clearText()
            self.baloon.isHidden = true
        }
        
    }
    
    func clearText(){
        self.text.text = ""
        self.text1.text = ""
        self.text2.text = ""
        self.text3.text = ""
        self.text4.text = ""
    }
    
    func animations() {
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "pedrao email")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/3
        self.pedrinho.position.x = self.frame.width/2 - 50
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.5)
        self.addChild(self.pedrinho)
        
        self.message = SKLabelNode()
        self.message.text = "Tap here to open the e-mail."
        self.message.fontSize = 60
        self.message.fontName = "ChalkboardSE-Bold"
        self.message.position = CGPoint(x: self.frame.midX + 35, y: self.frame.midY + self.frame.midY/2)
        self.message.zPosition = 1
        
        self.addChild(self.message)
        let scaleUp = SKAction.scale(to: 1.3, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1, duration: 0.3)
        let sqc = SKAction.sequence([scaleUp, scaleDown])
        self.message.run(SKAction.repeatForever(sqc))
        
    }
    
    func goFinal(){
        
        self.pedrinho.removeFromParent()
        self.pedrinho = SKSpriteNode(imageNamed: "pedrao wwdc")
        self.pedrinho.position.y = self.frame.midY - self.frame.midY/3
        self.pedrinho.position.x = self.frame.width/2 - 50
        self.pedrinho.zPosition = 1
        self.pedrinho.setScale(0.5)
        self.addChild(self.pedrinho)
        
        let wait = SKAction.wait(forDuration: 0.5)

        self.run(wait){
            self.pedrinho.removeFromParent()
            self.pedrinho = SKSpriteNode(imageNamed: "pedrao winner")
            self.pedrinho.position.y = self.frame.midY - self.frame.midY/3
            self.pedrinho.position.x = self.frame.width/2 - 50
            self.pedrinho.zPosition = 1
            self.pedrinho.setScale(0.5)
            self.addChild(self.pedrinho)
            self.baloon.isHidden = false
            self.fillText34()
            self.run(wait){
                self.fillText35()
                self.run(wait){
                    self.texto.text = "See ya!"
                    self.baloon2.addChild(self.texto)
                    self.addChild(self.baloon2)
                }
            }
        }
    }

    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began touched")
        let touch: UITouch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if self.message.contains(touchLocation){
            print("touched message")
            var sound2 = SKAction.playSoundFileNamed("final.mp3", waitForCompletion: true)
            self.run(SKAction.repeatForever(sound2))
            self.run(SKAction.wait(forDuration: 0.5)){
                self.message.run(SKAction.fadeOut(withDuration: 0.5)){
                    self.message.removeFromParent()
                    self.goFinal()
                }
            }
        }
    }
    
    
    // ----------------Baloon 1---------------- //
    
    func fillText(){
        self.text.animate(newText: "Yeah, the little", characterDelay: 0.1)
    }
    
    func fillText1(){
        self.text1.animate(newText: "boy grew up...", characterDelay: 0.1)
    }
    
    func fillText2(){
        self.text2.animate(newText: "and made this.", characterDelay: 0.1)
    }
    
    func fillText11(){
        self.text.animate(newText: "I'm not a soccer", characterDelay: 0.1)
    }
    
    func fillText12(){
        self.text1.animate(newText: "player, I'm an", characterDelay: 0.1)
    }
    
    func fillText13(){
        self.text2.animate(newText: "app developer...", characterDelay: 0.1)
    }
    
    func fillText14(){
        self.text.animate(newText: "I discovered", characterDelay: 0.1)
    }
    
    func fillText15(){
        self.text1.animate(newText: "that I can change", characterDelay: 0.1)
    }
    func fillText16(){
        self.text2.animate(newText: "the world with", characterDelay: 0.1)
    }
    func fillText17(){
        self.text3.animate(newText: "technology.", characterDelay: 0.1)
    }
    
    func fillText21(){
        self.text1.animate(newText: "Now, help me", characterDelay: 0.1)
    }
    func fillText22(){
        self.text2.animate(newText: "doing what I do:", characterDelay: 0.1)
    }
    func fillText23(){
        self.text3.animate(newText: "coding.", characterDelay: 0.1)
    }
    
    func fillText24(){
        self.text1.animate(newText: "Follow the instructions", characterDelay: 0.1)
    }
    func fillText25(){
        self.text2.animate(newText: "on the left", characterDelay: 0.1)
    }
    func fillText26(){
        self.text3.animate(newText: "than tap run my code", characterDelay: 0.1)
    }
    
    func fillText34(){
        self.text1.animate(newText: "Yeah! Uhul!", characterDelay: 0.1)
    }
    func fillText35(){
        self.text2.animate(newText: "See you in June!", characterDelay: 0.1)
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if self.called {
            self.called = false
            self.animations()
        }
    }
}
