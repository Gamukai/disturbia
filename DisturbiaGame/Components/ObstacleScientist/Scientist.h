//
//  ObstacleScientist.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Scientist : SKSpriteNode

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;
- (instancetype) initWithParent: (SKNode *) parentNode;

@end
