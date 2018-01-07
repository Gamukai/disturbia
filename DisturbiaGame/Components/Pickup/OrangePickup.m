//
//  OrangePickup.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/5/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "OrangePickup.h"

@implementation OrangePickup

static const CGFloat finalPosition = -50;
static const CGFloat duration = 4.0;


+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    OrangePickup* pickup = [[OrangePickup alloc] initWithParent: parentNode];
    pickup.delegate = parentNode;
    [parentNode addChild: pickup];
    return pickup;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super initWithImageNamed:@"test_tube"];
    if (self) {
        self.size = CGSizeMake(parentNode.frame.size.width * (1.0/24), parentNode.frame.size.width * (1.0/8));
        self.position = CGPointMake(parentNode.frame.size.width + (CGFloat)arc4random_uniform(10) * 60.0f,
                                    parentNode.frame.size.height / 6 + self.frame.size.height / 2 - self.frame.size.height * 0.17);

        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:
                            CGSizeMake(parentNode.frame.size.width * (1.0/17), parentNode.frame.size.height * (1.0/12))];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = pickupType;
        self.physicsBody.contactTestBitMask = heroType;
        self.zPosition = 100;

        [self animate];
    }
    return self;
}

- (void) animate
{
    [self runAction: [SKAction sequence: @[[SKAction moveToX: finalPosition duration: duration], [SKAction removeFromParent]]]];
    [self runAction: [SKAction repeatActionForever: [SKAction rotateByAngle: 360.0 duration: 30.0]]];
}

- (void) handleBeginContactWithOtherNode: (SKNode *) otherNode
{
    if (otherNode)
    {
        [self.parent runAction: [SKAction playSoundFileNamed:@"purple" waitForCompletion: NO]];
        [self removeFromParent];
        if (_delegate) [_delegate orangePickupDidCollected];
    }
}

#pragma mark - ContactListener

- (void) didBeginContact:(SKPhysicsContact *)contact
{
    SKNode * otherNode = contact.bodyA.categoryBitMask == pickupType
    ? contact.bodyB.node : contact.bodyA.node;

    [self handleBeginContactWithOtherNode: otherNode];
}

- (void) didEndContact:(SKPhysicsContact *)contact
{

}

@end
