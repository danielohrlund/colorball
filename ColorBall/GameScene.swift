//
//  GameScene.swift
//  ColorBall
//
//  Created by Daniel Öhrlund on 2014-09-16.
//  Copyright (c) 2014 getstranger. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var enemies : Array<SKShapeNode> = []
    
    var lastEnemyAddTime : CFTimeInterval = 0
    
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
        
        if currentTime > lastEnemyAddTime + 3 {
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
            let moveNodeDown = SKAction.moveByX(0, y: -1, duration: 1)
            enemy.runAction(moveNodeDown)
        }
    }
}
