import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var points = [[CGPoint]]()
    var blockWidth: CGFloat?
    var blockHeight: CGFloat?
    var viewSize : CGSize?
    
    override init(size: CGSize) {
        super.init(size: size)
        blockWidth = (size.width - 10)/6
        blockHeight = (size.height - 15)/10
        viewSize = size
        
        // Append values to points
        for i in 1...10{
            var row = [CGPoint]()
            for j in 1...6{
                row.append(CGPoint(x: 5 + (CGFloat(j)-0.5)*blockWidth! , y:500 + (CGFloat(i)-0.5)*blockHeight!))
            }
            points.append(row)
        }
    }
    

    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsWorld.gravity = .init(dx: 0, dy: -2)
        physicsWorld.speed = 2
        addGround()
        createInitialBlocks()
    }
    
    // This function adds Ground to avoid blocks falling off the screen
    func addGround(){
        var bottomPadding = size.height - (viewSize?.height)!
        if bottomPadding != 0{
            bottomPadding-=44
        }
        else{
            bottomPadding = 5;
        }
       
        var splinePoints = [CGPoint(x: 0, y: bottomPadding),
                            CGPoint(x: 500, y: bottomPadding)]
        let ground = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0
        ground.physicsBody?.categoryBitMask = 0b0001
        ground.physicsBody?.usesPreciseCollisionDetection = true
        addChild(ground)
    }
    
    // This Function Handle Touch Events
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let touchLocation = touch.location(in: self)
        let allNodes =  nodes(at: touchLocation)
        
        for node in allNodes{
            while let selectedNode = childNode(withName: node.name!){
                selectedNode.removeFromParent()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
