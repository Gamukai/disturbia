//
//  Hero.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "Hero.h"

@implementation Hero

- (instancetype)initWithParent:(SKNode *)parentNode
{
    self = [super initWithImageNamed:@"hero_running_000"];
    if (self) {
        self.size = CGSizeMake(parentNode.frame.size.width * (1.0/12), parentNode.frame.size.height * (1.0/4));
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:
                            CGSizeMake(parentNode.frame.size.width * (1.0/16), parentNode.frame.size.height * (1.0/6))];
        self.physicsBody.dynamic = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.collisionBitMask = terrainType;
        self.physicsBody.categoryBitMask = heroType;
        self.physicsBody.contactTestBitMask = pipeType;

        [self animate];
    }
    return self;
}

- (void)animate
{
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    int numberOFSprites = 0;

    while(numberOFSprites < 30)
    {
        if(numberOFSprites < 10)
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_running_00%d", numberOFSprites]]];
        }
        else
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_running_0%d", numberOFSprites]]];
        }
        numberOFSprites++;
    }

    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:animationFrames
                                      timePerFrame:0.02f
                                            resize:NO
                                           restore:YES]] withKey:@"runningHero"]; // WHAT?
    }

+ (id)createNodeOn:(SKNode *)parent
{
    id hero = [[Hero alloc] initWithParent: parent];
    [parent addChild:hero];
    return hero;
}

- (void)animateJump
{
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];

    int numberOFSprites = 0;

    while(numberOFSprites < 9)
    {
        [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_jumping_start_00%d", numberOFSprites]]];
        numberOFSprites++;
    }

    numberOFSprites = 0;

    while(numberOFSprites < 17)
    {
        if(numberOFSprites < 10)
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_jumping_during_00%d", numberOFSprites]]];
        }
        else
        {
            [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_jumping_during_0%d", numberOFSprites]]];
        }
        numberOFSprites++;
    }

    numberOFSprites = 0;

    while(numberOFSprites < 9)
    {
        [animationFrames addObject: [SKTexture textureWithImageNamed: [NSString stringWithFormat: @"hero_jumping_end_00%d", numberOFSprites]]];
        numberOFSprites++;
    }

    [self runAction:[SKAction animateWithTextures:animationFrames
                                     timePerFrame:0.04f
                                           resize:NO
                                          restore:YES] withKey:@"jumpingHero"];
    }

- (void)jump:(NSUInteger)times andParent:(SKNode *)parentNode
{
    if (times < 2)
    {
        BOOL ipad;

        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        ipad = YES; /* Device is iPad */
        else
        ipad = NO;

        self.physicsBody.velocity = CGVectorMake(0, 0);

        if (ipad == YES)
        [self.physicsBody applyImpulse:CGVectorMake(0, parentNode.frame.size.height * 0.23)];
        else
        [self.physicsBody applyImpulse:CGVectorMake(0, parentNode.frame.size.height * 0.08)];

        [self animateJump];
    }
}

@end
