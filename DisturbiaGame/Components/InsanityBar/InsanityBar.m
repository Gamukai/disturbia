//
//  InsanityBar.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "InsanityBar.h"

@implementation InsanityBar

- (instancetype)initWithParent: (SKNode *) parentNode
{
    if (self = [super init])
    {
        [self setPosition: CGPointMake(parentNode.frame.size.width * 0.54, parentNode.frame.size.height - parentNode.frame.size.height * 0.10)];
        SKTexture *maskTexture = [SKTexture textureWithImageNamed: @"insanity-bar-filled"];
        self.maskNode = [SKSpriteNode spriteNodeWithTexture:maskTexture size:CGSizeMake(parentNode.frame.size.width * 0.01, parentNode.frame.size.height * 0.1)];
        SKTexture *layerTexture = [SKTexture textureWithImageNamed: @"insanity-bar-empty"];
        SKSpriteNode *layer = [SKSpriteNode spriteNodeWithTexture:layerTexture size:CGSizeMake(parentNode.frame.size.width * 0.9, parentNode.frame.size.height * 0.1)];
        layer.anchorPoint = CGPointMake(1.0, 0.0);
        layer.zPosition = 16;
        [self addChild: layer];
    }
    return self;
}

- (void) setProgress: (CGFloat) progress
{
    self.maskNode.xScale = 100 - progress;
}

@end
