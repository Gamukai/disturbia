//
//  Pickup.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/30/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "Pickup.h"

@implementation Pickup

static const CGFloat finalPosition = -50;
static const CGFloat duration = 4.0;

+ (void)addNewNodeTo: (SKNode*) parentNode
{
    SKTexture *pickupTexture = [SKTexture textureWithImageNamed:@"test_tube"];
    SKSpriteNode *pickupNode = [SKSpriteNode spriteNodeWithTexture: pickupTexture size: CGSizeMake(parentNode.frame.size.width * (1.0/24), parentNode.frame.size.width * (1.0/8))];

    pickupNode.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                        parentNode.frame.size.height / 6 + pickupNode.frame.size.height / 2 - pickupNode.frame.size.height * 0.17);

    pickupNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(parentNode.frame.size.width * (1.0/17), parentNode.frame.size.height * (1.0/12))];
    pickupNode.physicsBody.dynamic = NO;
    pickupNode.physicsBody.categoryBitMask = pickupType;
    pickupNode.physicsBody.contactTestBitMask = heroType;
    pickupNode.zPosition = 100;
    [parentNode addChild: pickupNode];
    [self animate: pickupNode];
}

+ (void)animate:(SKNode *)node
{
    [node runAction: [SKAction sequence: @[[SKAction moveToX:finalPosition duration:duration],[SKAction removeFromParent]]]];
    [node runAction: [SKAction repeatActionForever: [SKAction rotateByAngle:360.0 duration:30.0]]];
}

@end
