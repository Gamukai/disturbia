//
//  GiantScientst.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/5/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "GiantScientist.h"

@implementation GiantScientist

static const CGFloat finalPosition = -50;
static const CGFloat duration = 6.0;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    GiantScientist* scientist = [[GiantScientist alloc] initWithParent: parentNode];
    scientist.delegate = parentNode;
    [parentNode addChild: scientist];
    return scientist;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super initWithImageNamed:@"scientist_walking_0"];
    if (self) {
        self.size = CGSizeMake(parentNode.frame.size.width * (1.0/8), parentNode.frame.size.height * (1.0/2));

        self.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                    parentNode.frame.size.height / 6 + self.frame.size.height / 2 - self.frame.size.height * 0.08);

        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:
                            CGSizeMake(parentNode.frame.size.width * (1.0/10), parentNode.frame.size.height * (1.0/3))];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = scientistType;
        self.physicsBody.contactTestBitMask = heroType;
        self.zPosition = 100;

        [self animate];
    }
    return self;
}

- (void) animate
{
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    int numberOFSprites = 0;

    while(numberOFSprites < 52)
    {
        [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"scientist_walking_%d", numberOFSprites]]];
        numberOFSprites++;
    }

    [self runAction: [SKAction sequence: @[[SKAction moveToX:finalPosition duration:duration],[SKAction removeFromParent]]]];
    [self runAction: [SKAction repeatActionForever: [SKAction animateWithTextures:animationFrames timePerFrame:0.01f]]];
}

- (void) handleBeginContactWithOtherNode: (SKNode *) otherNode
{
    if (otherNode)
    {
        [self.parent runAction: [SKAction playSoundFileNamed:@"green" waitForCompletion: NO]];
        [self removeFromParent];
    }
}

- (void) handleEndContactWithOtherNode: (SKNode *) otherNode
{
    if (otherNode)
    {
        if (_delegate) [_delegate giantScientistDidContacted];
    }
}

#pragma mark - ContactListener

- (void) didBeginContact:(SKPhysicsContact *)contact
{
    SKNode * otherNode = contact.bodyA.categoryBitMask == scientistType
    ? contact.bodyB.node : contact.bodyA.node;

    [self handleBeginContactWithOtherNode: otherNode];
}

- (void) didEndContact:(SKPhysicsContact *)contact
{
    SKNode * otherNode = contact.bodyA.categoryBitMask == scientistType
    ? contact.bodyB.node : contact.bodyA.node;

    [self handleEndContactWithOtherNode: otherNode];
}

@end
