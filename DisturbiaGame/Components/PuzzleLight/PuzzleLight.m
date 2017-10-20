//
//  PuzzleLight.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PuzzleLight.h"

@implementation PuzzleLight

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position color:(NSString *)color lifeTime:(NSTimeInterval)lifeTime
{
    SKTexture *lightTexture = [SKTexture textureWithImageNamed: color];
    if (self = [super initWithTexture:lightTexture color:[UIColor clearColor] size:size])
    {
        [self setPosition: position];
        [self setZPosition: 100];
        [self setUserInteractionEnabled: YES];
        self.lifeTimer = [NSTimer timerWithTimeInterval:lifeTime target:self selector:@selector(lightDeath) userInfo:nil repeats:NO];
        [self animate];
    }
    return self;
}

- (void) animate
{
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    int numberOFSprites = 0;

    while(numberOFSprites < 30)
    {
        if(numberOFSprites < 10)
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_running_00%d", numberOFSprites]]];
        }
        else
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_running_0%d", numberOFSprites]]];
        }
        numberOFSprites++;
    }

    [self runAction:[SKAction animateWithTextures:animationFrames
                                     timePerFrame:0.04f
                                           resize:NO
                                          restore:YES] completion:^{
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
