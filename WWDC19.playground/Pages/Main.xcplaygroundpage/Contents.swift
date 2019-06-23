import UIKit
import PlaygroundSupport
import SpriteKit

/*:
 ### The Blockchain: A Visual and Interactive Experience
 
 The Blockain is still a very new topic for most. It's became a huge topic of interest recently, especially since the recent successes of cryptocurrencies such as Bitcoin which surged to almost $20,000 a piece by the end of 2017!
 
 But what is Blockchain? It's the system that keeps it up and running and creates the potentional for a new type of internet - an internet of value instead of information.
 Take a look at the Playground to dive into the philosophy behind Bitcoin, how and why it matters, and also how it works first hand. Have fun!
 
 - Note:
 Please scale the live view to the proper and full size before viewing for the best experience (the only experience that matters honestly)
 
 Credits:
 1. Person Graphic - [Freepik](https://www.freepik.com/free-vector/set-vector-cartoon-illustrations-creating-character-businessman_1265777.htm)
 2. Nature Landscape Graphic - [Freepik](https://www.freepik.com/free-vector/jungle-landscape-with-trees-plants-illustration_3297754.htm)
 3. Kingdom Graphic - [FreePik](https://www.freepik.com/free-vector/castle-hall-hallway-medieval-palace-ballroom-dancing-royal-receptions_3519629.htm)
 4. King Graphic - [Freepik](https://www.freepik.com/free-vector/three-kings-background_3363358.htm)
 5. City Graphic - [Freepik](https://www.freepik.com/free-vector/modern-city-river-night_3824041.htm)
 6. Desk Worker Graphic - [Freepik](https://www.freepik.com/free-vector/professional-programmer-engineer-writing-code_1311615.htm)
 7. Forest Sound Effect - [Freesound](https://freesound.org/people/VKProduktion/sounds/231537/)
 9. Star Wars Font - [DaFont](https://www.dafont.com/star-jedi.font)
 8. Voiceover - My Beautiful Voice
 
 
 
 A Swift Playground by Mohammed Ibrahim for WWDC 2019
 */

// MARK: - SETUP SCENE
let masterView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 800))

let scene = MainScene(fileNamed: "MainScene")

let skView = SKView(frame: CGRect(x: 0, y: 0, width: 600, height: 800))
skView.presentScene(scene)

masterView.addSubview(skView)

scene?.historyOfTransactions(withParentView: masterView, completion: {
    scene?.blockchainTutorial(withParentView: masterView)
})

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = masterView
