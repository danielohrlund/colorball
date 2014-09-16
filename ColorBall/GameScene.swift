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
    
}
