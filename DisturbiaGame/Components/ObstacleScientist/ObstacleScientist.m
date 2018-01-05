//
//  ObstacleScientist.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "ObstacleScientist.h"

@implementation ObstacleScientist

static const CGFloat finalPosition = -50;
static const CGFloat duration = 6.0;

+ (void)addNewNodeTo: (SKNode*) parentNode
{
    [self nodeSetupWithParent: parentNode bodyWidth: 12.0 bodyHeight: 4.0 yPosition: 0.17 physicsBodyWidth: 14.0 physicsBodyHeight: 5.0];
}

+ (void)addNewCrazyNodeTo: (SKNode*) parentNode
{
    [self nodeSetupWithParent: parentNode bodyWidth: 8.0 bodyHeight: 2.0 yPosition: 0.08 physicsBodyWidth: 10.0 physicsBodyHeight: 3.0];
}

+ (void)nodeSetupWithParent:(SKNode *) parentNode bodyWidth:(CGFloat) bWidth bodyHeight:(CGFloat) bHeight yPosition:(CGFloat) y physicsBodyWidth:(CGFloat) pbWidth physicsBodyHeight:(CGFloat) pbHeight
{
    SKTexture *obstacleTexture = [SKTexture textureWithImageNamed:@"scientist_walking_0"];
    SKSpriteNode *obstacleNode = [SKSpriteNode spriteNodeWithTexture: obstacleTexture size: CGSizeMake(parentNode.frame.size.width * (1.0/bWidth), parentNode.frame.size.height * (1.0/bHeight))];

    obstacleNode.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                        parentNode.frame.size.height / 6 + obstacleNode.frame.size.height / 2 - obstacleNode.frame.size.height * y);

    obstacleNode.zPosition = 0;
    obstacleNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(parentNode.frame.size.width * (1.0/pbWidth), parentNode.frame.size.height * (1.0/pbHeight))];
    obstacleNode.physicsBody.dynamic = NO;
    obstacleNode.physicsBody.categoryBitMask = scientistType;
    obstacleNode.zPosition = 100;
    [parentNode addChild: obstacleNode];
    [self animate: obstacleNode];
}

+ (void)animate:(SKNode *)node
{
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    int numberOFSprites = 0;

    while(numberOFSprites < 52)
    {
        [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"scientist_walking_%d", numberOFSprites]]];
        numberOFSprites++;
    }

    [node runAction: [SKAction sequence: @[[SKAction moveToX:finalPosition duration:duration],[SKAction removeFromParent]]]];
    [node runAction: [SKAction repeatActionForever: [SKAction animateWithTextures:animationFrames timePerFrame:0.01f]]];
}

@end
