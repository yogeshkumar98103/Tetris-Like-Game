import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        var size : CGSize?
        
        if #available(iOS 11.0, *){
            size = self.view.safeAreaLayoutGuide.layoutFrame.size
        }
        else{
            print("before iOS 11")
            size = self.view.frame.size
        }
        
        let scene = GameScene(size: size!)
        let skView = view as! SKView
        
        scene.scaleMode = .resizeFill
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
