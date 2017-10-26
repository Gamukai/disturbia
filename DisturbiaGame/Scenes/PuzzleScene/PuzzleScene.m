//
//  PuzzleScene.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PuzzleScene.h"

@implementation PuzzleScene

#pragma mark - Life Cicle

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];

    self.data = [[PlistManager sharedManager] readFile];

    self.parentInsanity = [[self.data objectForKey:@"Insanity"] integerValue];

    self.clickCount = 0;
    self.createdLights = 0;
    self.numberOfLights = [[self.data objectForKey:@"Points"] integerValue];

    [self createWorld];
    [self createLights];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.clickCount >= self.numberOfLights)
    [self finishScene];
}

- (void) finishScene
{
    NSLog(@"Diparou no fim");
    BOOL success = (self.clickCount == self.numberOfLights);
    if (success == YES)
    self.parentInsanity = self.parentInsanity - 3;
    else
    self.parentInsanity = self.parentInsanity + 15;

    [self.data setObject: [NSNumber numberWithInteger: self.parentInsanity] forKey:@"Insanity"];

    NSLog(@"%@", self.data);
    [[PlistManager sharedManager] writeFileWith: self.data];

    [self.audioPlayer stop];

    [self.view presentScene: self.previousGameScene];
}

#pragma mark - Creators

- (void)createWorld
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor: [SKColor colorWithRed:0.0 green:17.0 blue:43.0 alpha:0.5] size: self.view.frame.size];
    background.color = SKColor.cyanColor;
    background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    background.zPosition = 10;
    [self addChild:background];
    self.scaleMode = SKSceneScaleModeAspectFit;

    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"home" ofType:@"mp3"]];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
}

#pragma mark - Light Methods

- (void)createLights
{
    if (self.createdLights < self.numberOfLights)
    {
        SKAction *waitAction = [SKAction waitForDuration: 1.0];
        SKAction *run = [SKAction runBlock:^{
            self.createdLights = self.createdLights + 1;
            CGSize size = CGSizeMake(self.frame.size.width * 0.1, self.frame.size.width * 0.1);
            PuzzleLight *light = [[PuzzleLight alloc] initWithSize:size position:[self createPoint] color:@"scientist_walking_0" lifeTime: [self calculateLifeTimeWith:self.numberOfLights]];
            light.delegate = self;
            [self addChild:light];
            [self createLights];
        }];
        [self runAction: [SKAction sequence: @[waitAction, run]]];
    }
}

- (CGPoint)createPoint
{
    NSNumber *sortedX = [NSNumber numberWithDouble: self.frame.size.width * 0.1 + self.frame.size.width * arc4random_uniform(80) / 100];
    NSNumber *sortedY = [NSNumber numberWithDouble: self.frame.size.height * 0.1 + self.frame.size.height * arc4random_uniform(80) / 100];
    return CGPointMake([sortedX doubleValue], [sortedY doubleValue]);
}

- (NSTimeInterval) calculateLifeTimeWith: (NSTimeInterval) base
{
    return 4 / (2 + base);
}

#pragma mark - DGPuzzleLight Delegate

- (void)tapped
{
    self.clickCount += 1;
}

- (void)died
{
    self.clickCount += 1;
}

@end
