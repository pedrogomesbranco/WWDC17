/*:
 # Pedro, the Soccer Star!
 
 ### Score 5 goals in less than 15 seconds!
 
 Instructions:
 1. Before run the code try to kick the ball 3 times swiping your finger on the ball to the goal;
 2. Tap "Run my code";
 3. Wait the live view reload and help Pedro!
 
 */
//#-hidden-code
//#-code-completion(everything, hide)
import UIKit
import SpriteKit
import PlaygroundSupport

let fontURL = Bundle.main.url(forResource: "scoreboard", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)

let fontURL2 = Bundle.main.url(forResource: "Gameplay", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontURL2! as CFURL, CTFontManagerScope.process, nil)

var controller = GameViewController()

PlaygroundPage.current.liveView = controller

func kickPower(force: Int){
    controller.gameScene.kickPower = CGFloat(force)
}

func showGoalKeeper(appear:Bool){
    controller.gameScene.goalKeeperAppear = appear
}

func goalKeeperVelocity(speed:Int){
    controller.gameScene.goalKeeperVelocity = CGFloat(speed)
}


//#-end-hidden-code

kickPower(force:/*#-editable-code*/1/*#-end-editable-code*/)
// force(min: 1, max: 10)
showGoalKeeper(appear:/*#-editable-code*/true/*#-end-editable-code*/)
// appear(false, true)
goalKeeperVelocity(speed:/*#-editable-code*/3/*#-end-editable-code*/)
// speed(min: 1, max: 6)

