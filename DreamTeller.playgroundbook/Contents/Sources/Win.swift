import SpriteKit
import GameplayKit

public class Win: SKScene {
    
    var background: SKSpriteNode!
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        
        self.background = SKSpriteNode(imageNamed: "win")
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.size = CGSize(width: 1024, height: 768)
        self.background.zPosition = 0
        self.addChild(self.background)
        
    }

    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
