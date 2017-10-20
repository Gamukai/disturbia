//
//  ObstacleScientist.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface ObstacleScientist : SKSpriteNode

+ (void)addNewNodeTo:(SKNode *)parentNode;
+ (void)addNewCrazyNodeTo: (SKNode*) parentNode;

@end
