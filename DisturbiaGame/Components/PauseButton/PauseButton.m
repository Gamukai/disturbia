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

+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    PauseButton *pauseButton = [[PauseButton alloc] initWithParent: parentNode];
    pauseButton.delegate = parentNode;
    [parentNode addChild: pauseButton];
    return pauseButton;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super initWithImageNamed:@"pause"];
    if (self) {
        self.size = CGSizeMake(parentNode.frame.size.width * 0.06, parentNode.frame.size.width * 0.06);
        self.position = CGPointMake(parentNode.frame.size.width - parentNode.frame.size.width * 0.02 - (parentNode.frame.size.width * 0.03), parentNode.frame.size.height - parentNode.frame.size.height * 0.1 - (parentNode.frame.size.width * 0.06) / 2 + parentNode.frame.size.height * 0.025);
        self.zPosition = 100;
        [self setUserInteractionEnabled: YES];
        _isPaused = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
