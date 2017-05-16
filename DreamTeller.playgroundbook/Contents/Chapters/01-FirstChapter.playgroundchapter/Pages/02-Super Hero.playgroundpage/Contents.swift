/*:
 # Pedro, the Super Hero!
 
 ### Defeat the androids!
 
 Instructions:
 1. Try to drag the hero and keep dragging to fire laser shots;
 2. You can't hit with the androids more than 2 times, they want to kill you;
 3. Tap "Run my code" to generate the androids;
 4. Wait the live view reload and help Pedro!
 */
//#-hidden-code
//#-code-completion(everything, hide)
import UIKit
import SpriteKit
import PlaygroundSupport

let fontURL = Bundle.main.url(forResource: "Gameplay", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)

let view = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))
let scene = GameSceneSpace(size: CGSize(width: 512, height: 768))

PlaygroundPage.current.liveView = view

func laserShotsFired(perSecond:Int){
    scene.shotsPerSec = Double(perSecond)
}

func generateEnemies(androidsNumber:Int){
    scene.numberAndroids = androidsNumber
}

func androidsVelocity(speed:Double){
    scene.velocityAndroids = speed
}

func shotsToDefeatTheBoss(total:Int){
    scene.shotsToKill = total
}
//#-end-hidden-code

generateEnemies(androidsNumber:/*#-editable-code*/10/*#-end-editable-code*/)
// androidsNumber(min: 10, max: 30)
androidsVelocity(speed:/*#-editable-code*/10/*#-end-editable-code*/)
// speed(min: 1, max: 100)
shotsToDefeatTheBoss(total:/*#-editable-code*/5/*#-end-editable-code*/)
// total(min: 2, max: 10)
laserShotsFired(perSecond:/*#-editable-code*/5/*#-end-editable-code*/)
// perSecond(min: 5, max: 20)

//#-hidden-code
view.presentScene(scene)
//#-end-hidden-code
