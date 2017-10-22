//
//  DeathScene.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "DeathScene.h"

@implementation DeathScene

#pragma mark - Life Cicle

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    [self createWorld];
}

#pragma mark - Creators

- (void)createWorld
{
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"dead-bg"];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size:self.view.frame.size];
    background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    [self addChild:background];
    self.scaleMode = SKSceneScaleModeAspectFit;

    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"dead" ofType:@"wav"]];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];

    self.deathLabel1 = [[SKLabelNode alloc] init];
    self.deathLabel1.fontSize = self.frame.size.height * 0.09;
    self.deathLabel1.fontColor = [UIColor colorWithRed: (103.0/255.0) green: (157.0/255.0) blue: (0.0/255.0) alpha:1];
    self.deathLabel1.fontName = @"8BIT WONDER";
    [self.deathLabel1 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)];
    [self.deathLabel1 setZPosition: 100];
    [self.deathLabel1 setText:[NSString stringWithFormat:@"LOST SIGNAL_"]];
    [self addChild: self.deathLabel1];
}

#pragma mark - Api

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
    MenuScene *newScene = [MenuScene sceneWithSize: self.size];
    [self.scene.view presentScene: newScene transition: reveal];
}

@end
