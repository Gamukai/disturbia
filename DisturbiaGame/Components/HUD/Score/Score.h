//
//  Score.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/7/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ScoreTimer.h"

@interface Score : SKLabelNode <ScoreTimerDelegate>

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

- (void) update;

@end
