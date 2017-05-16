/*:
 # Watch the live view animation before read the content!
 
 
 
 ### Do like me!
 
 After helping me being a super hero and a soccer player, now you can do exactly what I do.
 So, let's go!
 
 Instructions:
 
 1. Read the code below;
 2. I think you agree with the statements;
 3. Type the keepDreaming() method on the indicated area;
 4. Tap run my code;
 5. Wait the live view reload and enjoy!
 
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, keepDreaming())
import UIKit
import SpriteKit
import PlaygroundSupport

let view = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 768))
let scene = Pedro2(size: CGSize(width: 512, height: 768))

PlaygroundPage.current.liveView = view

let youLoveWhatYouDo = true

let youWantToMakeTheDifference = true

func keepDreaming(){
    scene.called = true
}
//#-end-hidden-code

if youLoveWhatYouDo && youWantToMakeTheDifference {
    //#-editable-code Tap to write your code
    //#-end-editable-code
}
//#-hidden-code
view.presentScene(scene)
//#-end-hidden-code
