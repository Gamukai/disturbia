//
//  Background.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/5/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "Background.h"

@implementation Background

+ (void) addNewNodeBackgroundTo: (SKNode *)parentNode
{
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"main-bg"];
    CGSize backgroundSize = CGSizeMake(parentNode.frame.size.width * 2, parentNode.frame.size.height);

    SKSpriteNode *backgroundNode1 = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size: backgroundSize];
    backgroundNode1.position = CGPointMake(parentNode.frame.size.width, parentNode.frame.size.height / 2 - backgroundNode1.frame.size.height / 2);
    backgroundNode1.zPosition = 9;

    SKSpriteNode *backgroundNode2 = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size: backgroundSize];
    backgroundNode2.position = CGPointMake(parentNode.frame.size.width * 2, parentNode.frame.size.height / 2 - backgroundNode2.frame.size.height / 2);
    backgroundNode2.anchorPoint = CGPointMake(0.0, 0.5);
    backgroundNode2.zPosition = 9;

    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size: backgroundSize];
    background.position = CGPointMake(0.0, parentNode.frame.size.height / 2);
    background.anchorPoint = CGPointMake(0.0, 0.5);
    background.zPosition = 9;

    [background addChild: backgroundNode2];
    [parentNode addChild: background];

    [background runAction:[SKAction repeatActionForever:
                           [SKAction sequence:@[
                                                [SKAction moveToX: -2 * parentNode.frame.size.width duration:10.0f],
                                                [SKAction moveToX: 0 duration:.0f]
                                                ]]]];
}

@end
