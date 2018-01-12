//
//  ObstacleScientist.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "Scientist.h"

@implementation Scientist

static const CGFloat finalPosition = -50;
static const CGFloat duration = 6.0;

+ (instancetype) createNodeOnParent: (SKNode<ScientistDelegate> *) parentNode
{
    Scientist* scientist = [[Scientist alloc] initWithParent: parentNode];
    scientist.delegate = parentNode;
    [parentNode addChild: scientist];
    return scientist;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super initWithImageNamed:@"scientist_walking_0"];
    if (self) {
        self.size = CGSizeMake(parentNode.frame.size.width * (1.0/12), parentNode.frame.size.height * (1.0/4));

        self.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                    parentNode.frame.size.height / 6 + self.frame.size.height / 2 - self.frame.size.height * 0.17);

        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:
                            CGSizeMake(parentNode.frame.size.width * (1.0/14), parentNode.frame.size.height * (1.0/5))];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = scientistType;
        self.physicsBody.contactTestBitMask = heroType;
        self.zPosition = 100;

        [self animate];
    }
    return self;
}

- (void)animate
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
        [self.parent runAction: [SKAction playSoundFileNamed:@"yellow" waitForCompletion: NO]];
        [self removeFromParent];
        if (_delegate) [_delegate scientistDidContacted];
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

}

@end
