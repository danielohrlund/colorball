//
//  GameScene.swift
//  ColorBall
//
//  Created by Daniel Öhrlund on 2014-09-16.
//  Copyright (c) 2014 getstranger. All rights reserved.
//

import SpriteKit

//TODO
//move to a new class

//create an interface
//create a delegate

class TouchHelper : NSObject {
    
    
}

class GameScene: SKScene {


//DANIEL
    var enemies : Array<SKShapeNode> = []
    
    var lastEnemyAddTime : CFTimeInterval = 0

//CA
    var isRotatingLeft:Bool, directionIsDecided:Bool
    var lastTouch : CGPoint
    var startOfTouch : CGPoint
    
    var totalMoved : CGFloat;
    
    required init(coder aDecoder: NSCoder) {
        //   fatalError("init(coder:) has not been implemented")
        self.isRotatingLeft = false
        self.directionIsDecided = false
        self.lastTouch = CGPointZero
        self.startOfTouch = CGPointZero
        totalMoved = 0;
        super.init(coder: aDecoder)
    }
    

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            decideWhichDirectionWeAreGoingIn(startOfTouch, currentPoint: location)
            let distance = distanceWeHaveMoved(self.lastTouch, currentPoint: location)
            haveMovedDistance(distance);
            self.lastTouch = location;
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        directionIsDecided = false
                totalMoved = 0
        print("setting totalmoved to 0! touches begain")
        
        for touch in touches {
            startOfTouch = touch.locationInNode(self)
            self.lastTouch = startOfTouch;
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        startOfTouch = CGPointZero

    }
    
    private func decideWhichDirectionWeAreGoingIn(startPoint:CGPoint, currentPoint:CGPoint)
    {
        if directionIsDecided
        {
        return;
        }
        
        //we do not know where the fuck we are going. find out
        
        var goingUpwards = currentPoint.y > startPoint.y;
        //        var goingDown = currentPoint.y < startPoint.y;
        //        var goingLeft = currentPoint.x < startPoint.x;
        var goingRight = currentPoint.x > startPoint.x;
        
        var turnRight = goingRight || goingUpwards;
        //        var turnRight = goingUpwards || goingRight;
        
        isRotatingLeft = !turnRight
        directionIsDecided = true
        
    }
    
    private func haveMovedDistance(distance: CGFloat){
        if isRotatingLeft {
        totalMoved = totalMoved - distance
        }
        else {
            totalMoved = totalMoved  + distance;
        }
    println(totalMoved);
    }
    
    func distanceWeHaveMoved(lastPoint:CGPoint, currentPoint:CGPoint) -> CGFloat
    {
        let distance = hypot(currentPoint.x - lastPoint.x, currentPoint.y - lastPoint.y);
        //   println("distance betweeeeeeeeen points")
        //print(distance)
        return distance;
}
    
    var theBall : SKSpriteNode = SKSpriteNode(imageNamed:"Boll")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode()
        myLabel.text = "Color Ball"
        myLabel.fontSize = 49
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height - 100)
        
        self.addChild(myLabel)
        
        
        let ballWidth : CGFloat = 120
        let ballHeight : CGFloat = ballWidth
        let circle = CGRect(x: 0, y: 0, width: ballWidth, height: ballHeight)

//        let myBall = SKShapeNode()
        theBall.xScale = 1
        theBall.yScale = 1
//        myBall.path = UIBezierPath(ovalInRect: circle).CGPath
//        myBall.fillColor = SKColor.redColor()
//        myBall.lineWidth = 0
        theBall.position = CGPoint(x:CGRectGetMidX(self.frame) - ballWidth / 2, y: 0 + ballHeight / 2)
        
        
        self.addChild(theBall)
    }
    
    let enemySpeed : CGFloat = 4
    let enemySecondIncrements : CFTimeInterval = 3
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if currentTime > lastEnemyAddTime + enemySecondIncrements {
            lastEnemyAddTime = currentTime
            
            let newEnemy = SKShapeNode()
            let ballWidth : CGFloat = 25
            let ballHeight : CGFloat = ballWidth
            let circle = CGRect(x: 0, y: 0, width: ballWidth, height: ballHeight)
            newEnemy.path = UIBezierPath(ovalInRect: circle).CGPath
            newEnemy.fillColor = SKColor.blackColor()
            newEnemy.lineWidth = 0
            newEnemy.position = CGPoint(x: CGRectGetMidX(self.frame) - ballWidth / 2, y: self.frame.height - 100)
            
            enemies.append(newEnemy)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.addChild(newEnemy)
            })
        }

        for enemy : SKShapeNode in enemies {
            let moveNodeDown = SKAction.moveByX(0, y: -enemySpeed, duration: 0)
            enemy.runAction(moveNodeDown)
        }
    }
    
}
