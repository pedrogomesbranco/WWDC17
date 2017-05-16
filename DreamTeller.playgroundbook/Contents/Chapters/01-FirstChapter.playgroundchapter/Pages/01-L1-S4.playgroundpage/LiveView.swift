import UIKit
import SpriteKit
import PlaygroundSupport

let view = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
let scene = GameSceneAnimation(size: CGSize(width: 1024, height: 768))

scene.scaleMode = .aspectFill

view.presentScene(scene)
PlaygroundPage.current.liveView = view
