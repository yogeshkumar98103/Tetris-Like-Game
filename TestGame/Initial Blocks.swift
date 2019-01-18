import UIKit
import SpriteKit

extension GameScene{
    
    func createInitialBlocks(){
        
        var name = "1"
        var color = UIColor(red:0.95, green:0.66, blue:0.63, alpha:1.0)
        var positions = [[7,1],[8,1],[9,1],[7,2],[9,2]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "2"
        color = UIColor(red:0.15, green:0.76, blue:0.51, alpha:1.0)
        positions = [[6,2],[6,3],[7,3],[8,3],[8,2]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "3"
        color = UIColor(red:0.85, green:0.12, blue:0.09, alpha:1.0)
        positions = [[7,4]]
        addBlocks(at: positions,name: name, color: color)

        name = "4"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[6,4]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "5"
        color = UIColor(red:0.53, green:0.83, blue:0.49, alpha:1.0)
        positions = [[5,1],[5,2],[5,3]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "6"
        color = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        positions = [[5,4]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "7"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[4,4]]
        addBlocks(at: positions,name: name, color: color)

        name = "8"
        color = UIColor(red:0.86, green:0.04, blue:0.36, alpha:1.0)
        positions = [[3,2],[3,3],[4,3]]
        addBlocks(at: positions,name: name, color: color)

        name = "9"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[3,1]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "10"
        color = UIColor(red:0.78, green:0.97, blue:0.77, alpha:1.0)
        positions = [[3,4],[3,5]]
        addBlocks(at: positions,name: name, color: color)

        name = "11"
        color = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        positions = [[2,1]]
        addBlocks(at: positions,name: name, color: color)

        name = "12"
        color = UIColor(red:1.00, green:0.80, blue:0.02, alpha:1.0)
        positions = [[0,2],[0,1],[0,3],[1,2],[2,2],[2,3],[2,4]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "13"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[2,5]]
        addBlocks(at: positions,name: name, color: color)

        name = "14"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[1,3]]
        addBlocks(at: positions,name: name, color: color)

        name = "15"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[1,1]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "16"
        color = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        positions = [[1,5]]
        addBlocks(at: positions,name: name, color: color)

        name = "17"
        color = UIColor(red:0.59, green:0.21, blue:0.58, alpha:1.0)
        positions = [[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0]]
        addBlocks(at: positions,name: name, color: color)

        name = "18"
        color = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        positions = [[0,4]]
        addBlocks(at: positions,name: name, color: color)
        
        name = "19"
        color = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        positions = [[0,5]]
        addBlocks(at: positions,name: name, color: color)
    }
    
    // This function adds SubBlocks to Bigger Block
    func addBlocks(at positions : [[Int]], name: String, color: UIColor){
        var subBlocks = [SKShapeNode]()
        for position in positions{
            subBlocks.append(newSubBlock(position: points[position[0]][position[1]],name : name,color : color))
        }

        addConstraints(subBlocks)
    }
    
    // This Functions Links different SubBlocks of a Bigger Block
    func addConstraints(_ blocks : [SKShapeNode]){
        let anchor = blocks[0].position
        blocks[0].physicsBody?.allowsRotation = false
        if(blocks.count > 1){
            for i in 1..<blocks.count{
                let joint = SKPhysicsJointFixed.joint(withBodyA: blocks[i].physicsBody!, bodyB: blocks[0].physicsBody!, anchor: anchor)
                self.physicsWorld.add(joint)
            }
        }
    }
    
    // This Function generates subBlocks for Bigger Blocks
    func newSubBlock(position : CGPoint, name: String, color: UIColor)->SKShapeNode{
        let shape = CGSize(width: blockWidth!-5, height: blockHeight!-5)
        let physicsShape = CGSize(width: blockWidth!-1, height: blockHeight!)
        let block = SKShapeNode(rectOf: shape)
        block.name = name
        block.fillColor = color
        block.strokeColor = .black
        block.position = position
        block.physicsBody = SKPhysicsBody(rectangleOf: physicsShape)
        block.physicsBody?.collisionBitMask = 0b001
        block.physicsBody?.restitution = 0
        block.physicsBody?.usesPreciseCollisionDetection = true
        block.constraints = [SKConstraint.positionX(SKRange(value: position.x, variance: 0))]
        
        let label = SKLabelNode(text: name)
        label.name = name
        label.fontName = "AvenirNext-Medium"
        label.fontSize = 24
        label.position.y = label.position.y - label.frame.size.height/2
        
        block.addChild(label)
        addChild(block)
        return block
    }
}
