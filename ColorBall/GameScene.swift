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
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
