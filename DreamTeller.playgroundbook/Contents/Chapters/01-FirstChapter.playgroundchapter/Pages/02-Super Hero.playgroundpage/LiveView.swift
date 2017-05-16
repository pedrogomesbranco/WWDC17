import UIKit
import SpriteKit
import PlaygroundSupport

let fontURL = Bundle.main.url(forResource: "Gameplay", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)

let view = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))
let scene = SpaceBefore(size: CGSize(width: 512, height: 768))

view.presentScene(scene)
PlaygroundPage.current.liveView = view
