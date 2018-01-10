//
//  InsanityBar.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "InsanityBar.h"

@implementation InsanityBar

+ (instancetype) createNodeOnParent: (SKNode<InsanityBarDelegate> *) parentNode
{
    InsanityBar *insanityBar = [[InsanityBar alloc] initWithParent: parentNode];
    SKSpriteNode *insanityBarBackground = [InsanityBar createInsanityBarBackgroundWithParent: parentNode];
    [parentNode addChild: insanityBar];
    [parentNode addChild: insanityBarBackground];
    insanityBar.delegate = parentNode;
    return insanityBar;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    if (self = [super init])
    {
        self.position = CGPointMake(parentNode.frame.size.width * 0.54, parentNode.frame.size.height * 0.9);
        self.zPosition = 51;

        SKTexture *texture = [SKTexture textureWithImageNamed: @"insanity-bar-empty"];
        self.maskNode = [SKSpriteNode spriteNodeWithTexture: texture size: CGSizeMake(parentNode.frame.size.width * 0.01, parentNode.frame.size.height * 0.1)];
        self.maskNode.xScale = 100;

        SKSpriteNode *layer = [SKSpriteNode spriteNodeWithTexture: texture size: CGSizeMake(parentNode.frame.size.width, parentNode.frame.size.height * 0.1)];
        layer.anchorPoint = CGPointMake(1.0, 0.0);

        _insanityTimer = [InsanityTimer createNewInsanityTimerWithCounter: 0 andIntervalTopValue: 1 andIntervalBottomValue: 1 andDelegate: self];
        _insanityHelperTimer = [InsanityHelperTimer createNewInsanityHelperTimerWithCounter: 0 andIntervalTopValue: 50 andIntervalBottomValue: 50 andDelegate: self];

        [self addChild: layer];
    }
    return self;
}

+ (SKSpriteNode *) createInsanityBarBackgroundWithParent: (SKNode *) parentNode
{
    SKTexture *textureInsanity = [SKTexture textureWithImageNamed:@"insanity-bar-filled"];
    SKSpriteNode *layerInsanity = [SKSpriteNode spriteNodeWithTexture: textureInsanity size: CGSizeMake(parentNode.frame.size.width * 0.484, parentNode.frame.size.height * 0.06)];
    layerInsanity.anchorPoint = CGPointMake(1.0, 0.0);
    layerInsanity.position = CGPointMake(parentNode.frame.size.width * 0.515, parentNode.frame.size.height * 0.9);
    layerInsanity.zPosition = 50.0;
    return layerInsanity;
}

- (void) setProgress: (NSInteger) progress
{
    self.maskNode.xScale = 100 - progress;
}

#pragma mark - Insanity Timer Delegate

- (void) insanityEventDidOccurredWithValue: (NSInteger) value
{
    if (_delegate) value > 99 ? [_delegate maxValueUpdate] : [_delegate updateWithInsanity: value];
}

#pragma mark - Insanity Helper Timer Delegate

- (void) insanityHelperEventDidOccurred
{
    [_insanityTimer update];
    [self setProgress: _insanityTimer.counter];
}

@end
