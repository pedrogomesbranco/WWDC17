import UIKit
import SpriteKit
import PlaygroundSupport

let view = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))
let scene = Pedro(size: CGSize(width: 512, height: 768))

view.presentScene(scene)
PlaygroundPage.current.liveView = view
