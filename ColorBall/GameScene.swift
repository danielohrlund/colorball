//
//  GameScene.swift
//  ColorBall
//
//  Created by Daniel Öhrlund on 2014-09-16.
//  Copyright (c) 2014 getstranger. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
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

        let myBall = SKShapeNode()
        myBall.path = UIBezierPath(ovalInRect: circle).CGPath
        myBall.fillColor = SKColor.redColor()
        myBall.lineWidth = 0
        myBall.position = CGPoint(x:CGRectGetMidX(self.frame) - ballWidth / 2, y: 0 + ballHeight / 2)
        
        
        self.addChild(myBall)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
