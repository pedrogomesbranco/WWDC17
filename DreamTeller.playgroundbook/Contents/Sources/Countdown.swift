import SpriteKit

public class CowntdownLabel: SKLabelNode {
    
    var endTime:Date!
   
    func update(){
        let timeLeftInteger = Int(timeLeft())
        text = "\(String(timeLeftInteger))s               \(String(timeLeftInteger))s"
    }
    func startWithDuration(_ duration: TimeInterval){
        let timeNow = Date();
        endTime = timeNow.addingTimeInterval(duration)
    }

    
    func hasFinished() -> Bool{
        return timeLeft() == 0
    }
    
    fileprivate func timeLeft() -> TimeInterval{
        let now = Date()
        let remainSeconds = endTime.timeIntervalSince(now)
        return(max(remainSeconds, 0))
    }
}
