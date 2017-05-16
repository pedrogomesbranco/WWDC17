import UIKit
import SpriteKit
import PlaygroundSupport

let fontURL = Bundle.main.url(forResource: "scoreboard", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)

PlaygroundPage.current.liveView = GameViewControllerBefore()
