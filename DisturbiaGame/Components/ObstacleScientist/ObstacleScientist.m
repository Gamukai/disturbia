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
    SKTexture *obstacleTexture = [SKTexture textureWithImageNamed:@"scientist_walking_0"];
    SKSpriteNode *obstacleNode = [SKSpriteNode spriteNodeWithTexture: obstacleTexture size: CGSizeMake(parentNode.frame.size.width * (1.0/12), parentNode.frame.size.height * (1.0/4))];

    obstacleNode.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                        parentNode.frame.size.height / 6 + obstacleNode.frame.size.height / 2 - obstacleNode.frame.size.height * 0.17);

    obstacleNode.zPosition = 0;
    obstacleNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(parentNode.frame.size.width * (1.0/14), parentNode.frame.size.height * (1.0/5))];
    obstacleNode.physicsBody.dynamic = NO;
    obstacleNode.physicsBody.categoryBitMask = pipeType;
    obstacleNode.zPosition = 100;
    [parentNode addChild: obstacleNode];
    [self animate: obstacleNode];
}

+ (void)addNewCrazyNodeTo: (SKNode*) parentNode
{
    SKTexture *obstacleTexture = [SKTexture textureWithImageNamed:@"scientist_walking_0"];
    SKSpriteNode *obstacleNode = [SKSpriteNode spriteNodeWithTexture: obstacleTexture size: CGSizeMake(parentNode.frame.size.width * (1.0/8), parentNode.frame.size.height * (1.0/2))];

    obstacleNode.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                        parentNode.frame.size.height / 6 + obstacleNode.frame.size.height / 2 - obstacleNode.frame.size.height * 0.08);

    obstacleNode.zPosition = 0;
    obstacleNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(parentNode.frame.size.width * (1.0/10), parentNode.frame.size.height * (1.0/3))];
    obstacleNode.physicsBody.dynamic = NO;
    obstacleNode.physicsBody.categoryBitMask = pipeType;
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
