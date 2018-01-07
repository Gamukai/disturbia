//
//  Ground.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "Ground.h"

@implementation Ground

static const CGFloat duration = 5.0;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    Ground* ground = [[Ground alloc] initWithParent: parentNode];
    ground.delegate = parentNode;
    [parentNode addChild: ground];
    return ground;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super init];
    if (self) {
        SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"ground"];

        CGSize groundSize = CGSizeMake(parentNode.frame.size.width, parentNode.frame.size.height / 6);

        SKSpriteNode *groundContainer = [SKSpriteNode spriteNodeWithColor: UIColor.clearColor size: CGSizeMake(0.0, 0.0)];
        groundContainer.zPosition = 30;

        SKSpriteNode *groundFirstPiece = [SKSpriteNode spriteNodeWithTexture: groundTexture size: groundSize];
        groundFirstPiece.anchorPoint = CGPointMake(0.0f, 0.5f);

        SKSpriteNode *groundSecondPiece = [SKSpriteNode spriteNodeWithTexture: groundTexture size: groundSize];
        groundSecondPiece.position = CGPointMake(parentNode.frame.size.width, 0.0f);
        groundSecondPiece.anchorPoint = CGPointMake(0.0f, 0.5f);

        [groundContainer addChild: groundFirstPiece];
        [groundContainer addChild: groundSecondPiece];
        [self addChild: groundContainer];

        self.position = CGPointMake(0.0f, parentNode.frame.size.height / 12.5);
        self.zPosition = 10;

        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: groundSize];
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = terrainType;
        self.physicsBody.contactTestBitMask = heroType;

        [self animateNode: groundContainer withParent: parentNode];
    }
    return self;
}

- (void) animateNode: (SKNode *) node withParent: (SKNode *) parent
{
    [node runAction:[SKAction repeatActionForever:
                       [SKAction sequence:@[
                                            [SKAction moveToX: -1.0 * parent.frame.size.width duration: duration],
                                            [SKAction moveToX: 0 duration:.0f]
                                            ]]]];
}

- (void) handleBeginContactWithOtherNode: (SKNode *) otherNode
{
    if (otherNode)
    {
        if (_delegate) [_delegate groundDidTouched];
    }
}

#pragma mark - ContactListener

- (void) didBeginContact:(SKPhysicsContact *)contact
{
    SKNode * otherNode = contact.bodyA.categoryBitMask == terrainType
    ? contact.bodyB.node : contact.bodyA.node;

    [self handleBeginContactWithOtherNode: otherNode];
}

- (void) didEndContact:(SKPhysicsContact *)contact
{

}

@end
