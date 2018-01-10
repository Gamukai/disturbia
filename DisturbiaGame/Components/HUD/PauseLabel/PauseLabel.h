//
//  PauseLabel.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PauseLabel : SKLabelNode

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
