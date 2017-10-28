//
//  PuzzleLight.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PuzzleLight.h"

@implementation PuzzleLight

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position color:(UIColor *)color lifeTime:(NSTimeInterval)lifeTime
{
    SKTexture *lightTexture = [SKTexture textureWithImageNamed: @"Ball"];
    if (self = [super initWithTexture:lightTexture color:color size:size])
    {
        [self setPosition: position];
        [self setZPosition: 100];
        [self setUserInteractionEnabled: YES];
        self.colorBlendFactor = 1.0;
        self.lifeTimer = [NSTimer timerWithTimeInterval:lifeTime target:self selector:@selector(lightDeath) userInfo:nil repeats:NO];
        self.lifeTime = lifeTime;
        [self animate];
    }
    return self;
}

- (void) animate
{
    [self runAction:[SKAction scaleTo:2.0
                             duration:self.lifeTime] completion:^{
        if (self.delegate) [self.delegate died];
        [self removeFromParent];
    }];
}

- (void) lightDeath
{
    [self removeFromParent];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate)
    [self.delegate tapped];
    [self removeFromParent];
}

@end
