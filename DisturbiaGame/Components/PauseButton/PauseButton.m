//
//  PauseButton.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PauseButton.h"

@interface PauseButton ()

@property (nonatomic) BOOL isPaused;

@end

@implementation PauseButton

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position
{
    SKTexture *pauseTexture = [SKTexture textureWithImageNamed: @"pause"];
    if (self = [super initWithTexture:pauseTexture color:[UIColor clearColor] size:size])
    {
        [self setPosition:position];
        [self setUserInteractionEnabled: YES];
        self.isPaused = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Ronaldo Balão");
    if (self.isPaused)
    {
        SKTexture *pauseTexture = [SKTexture textureWithImageNamed: @"pause"];
        [self setTexture:pauseTexture];
        self.isPaused = NO;
        [self.delegate play];
    }
    else
    {
        SKTexture *playTexture = [SKTexture textureWithImageNamed: @"play"];
        [self setTexture:playTexture];
        self.isPaused = YES;
        [self.delegate pause];
    }
}

@end
