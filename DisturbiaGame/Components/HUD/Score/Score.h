//
//  Score.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/7/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Score : SKLabelNode

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

- (void) setNewScoreValue: (NSInteger) scoreValue;

@end
