//
//  Ground.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "Ground.h"

@implementation Ground

+ (void)addNewNodeTo:(SKNode *)parentNode
{
    //    SKEmitterNode *smoke1 = [NSKeyedUnarchiver unarchiveObjectWithFile: [[NSBundle mainBundle] pathForResource:@"Smoke" ofType: @"sks"]];
    //    smoke1.particlePosition = CGPointMake(parentNode.frame.size.width - parentNode.frame.size.width * 0.23,
    //                                          parentNode.frame.size.height - parentNode.frame.size.height *0.25);
    //    smoke1.particleZPosition = 200;
    //    smoke1.name = @"spark";
    //    smoke1.targetNode = parentNode.scene;
    //
    //SKEmitterNode *smoke2 = [NSKeyedUnarchiver unarchiveObjectWithFile: [[NSBundle mainBundle] pathForResource:@"Smoke" ofType: @"sks"]];
    //smoke2.particlePosition = CGPointMake(parentNode.frame.size.width * 0.26, parentNode.frame.size.height - parentNode.frame.size.height *0.25);
    //smoke2.particleZPosition = 200;
    //smoke2.name = @"spark";
    //smoke2.targetNode = parentNode.scene;

    SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"ground"];
    CGSize groundSize = CGSizeMake(parentNode.frame.size.width, parentNode.frame.size.height / 6);

    SKSpriteNode *groundCompletion = [SKSpriteNode spriteNodeWithTexture:groundTexture size: groundSize];
    groundCompletion.anchorPoint = CGPointMake(0, 1);
    groundCompletion.position = CGPointMake(parentNode.frame.size.width, parentNode.frame.size.height / 6 - groundCompletion.frame.size.height);
    // GAMBIARRA DESCONHECIDA, O PONTO DE ANCORA INDUZ QUE ESTE ESTÁ CORRETO E QUE O PAI ESTÁ INCORRETO.
    groundCompletion.zPosition = 10;

    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithTexture:groundTexture size: groundSize];
    ground.anchorPoint = CGPointMake(0, 1);
    ground.position = CGPointMake(0.0f, parentNode.frame.size.height / 6);
    ground.zPosition = 10;

    [ground addChild:groundCompletion];
    //[ground addChild: smoke1];
    //[ground addChild: smoke2];
    [parentNode addChild:ground];

    SKNode *groundBody = [SKNode node];
    groundBody.position = CGPointMake(parentNode.frame.size.width / 2, parentNode.frame.size.height / 6 - ground.frame.size.height / 2);
    groundBody.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: ground.frame.size];
    groundBody.physicsBody.dynamic = NO;
    groundBody.physicsBody.affectedByGravity = NO;
    groundBody.physicsBody.collisionBitMask = 0;
    groundBody.physicsBody.categoryBitMask = terrainType;
    groundBody.physicsBody.contactTestBitMask = heroType;
    [parentNode addChild: groundBody];

    [ground runAction:[SKAction repeatActionForever:
                       [SKAction sequence:@[
                                            [SKAction moveToX: -parentNode.frame.size.width duration:5.0f],
                                            [SKAction moveToX: 0 duration:.0f]
                                            ]]]];
}

+ (void)addNewNodeBackgroundTo:(SKNode *)parentNode
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
