//
//  GameScene.swift
//  L1-S4
//
//  Created by Pedro Gomes Branco on 29/03/17.
//  Copyright © 2017 Pedro Gomes Branco. All rights reserved.
//

import SpriteKit
import GameplayKit

public class GameSceneAnimation: SKScene {
    
    var background: SKSpriteNode!
    var start: SKSpriteNode!
    var text: SKSpriteNode!
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        
        var sound2 = SKAction.playSoundFileNamed("intro", waitForCompletion: true)
        self.run(SKAction.repeatForever(sound2))
        self.backgroundColor = UIColor.white
        
        self.background = SKSpriteNode(imageNamed: "fundo2")
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.size = self.frame.size
        self.background.zPosition = 0
        self.addChild(self.background)
        
        self.start = SKSpriteNode(imageNamed: "start")
        let startProportion = (start.texture?.size().height)!/(start.texture?.size().width)!
        self.start.size = CGSize(width: self.size.width/5, height: self.size.width/5 * startProportion)
        self.start.position = CGPoint(x: self.frame.midX, y: self.frame.midY - self.frame.midY/1.8)
        self.start.zPosition = 1
        self.addChild(self.start)
        
        let startBtnScaleUp = SKAction.scale(to: 1.15, duration: 0.5)
        let startBtnScaleDown = SKAction.scale(to: 1, duration: 0.5)
        let startBtnAnimation = SKAction.sequence([startBtnScaleUp, startBtnScaleDown])
        
        self.start.run(SKAction.repeatForever(startBtnAnimation))

        self.text = SKSpriteNode(imageNamed: "text")
        let w = self.size.width/2 - 100
        let textProportion = (text.texture?.size().height)!/(text.texture?.size().width)!
        self.text.size = CGSize(width: w, height: w * textProportion)
        self.text.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.start.size.height)
        self.text.zPosition = 2
        self.addChild(self.text)
    
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began touched")
        let touch: UITouch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if self.start.contains(touchLocation) {
            print("touched start")
            
            let nextScene = Lisa(size: self.size)
            nextScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(with: UIColor.clear, duration: 0.25)
            self.view?.presentScene(nextScene, transition: transition)

        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
