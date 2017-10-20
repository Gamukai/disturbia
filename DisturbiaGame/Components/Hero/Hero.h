//
//  Hero.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Hero : SKSpriteNode

+ (id)createNodeOn:(SKNode *)parent;

- (instancetype) initWithParent:(SKNode *)parentNode;
- (void)update;
- (void)jump:(NSUInteger)times andParent:(SKNode *)parentNode;

@end
