//
//  MenuScene.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

#pragma mark - Life Cycle

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];

    self.data = [[PlistManager sharedManager] readFile];

    [self createWorld];
    [self createLogo];
    [self createStartButton];
}

#pragma mark - Creators

- (void)createWorld
{
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"menu-bg"];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size:self.view.frame.size];
    background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    [self addChild:background];
    self.scaleMode = SKSceneScaleModeAspectFit;

    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"home" ofType:@"mp3"]];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
}

- (void)createLogo
{
    SKTexture *logoTexture = [SKTexture textureWithImageNamed: @"logo"];
    SKSpriteNode *logo = [SKSpriteNode spriteNodeWithTexture: logoTexture size:CGSizeMake(self.frame.size.width * 0.65, self.frame.size.height * 0.65)];
    logo.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 1.75);
    [logo setZPosition: 100];
    [self addChild: logo];

}

- (void)createStartButton
{
    self.startButton = [[SKLabelNode alloc] init];
    self.startButton.fontSize = self.frame.size.height * 0.035;
    self.startButton.fontColor = [UIColor colorWithRed: (153.0/255.0) green: (233.0/255.0) blue: 0 alpha:1];
    self.startButton.fontName = @"8BIT WONDER";
    [self.startButton setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.15)];
    [self.startButton setText:[NSString stringWithFormat:@"TAP TO SAVE YOUR MIND_"]];
    [self.startButton setZPosition: 100];
    [self addChild: self.startButton];
}

#pragma mark - Api

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[self.data objectForKey:@"Tutorial"] intValue] == 1) {

        SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
        GameScene *newScene = [[GameScene alloc] initWithSize: self.size andDistance:0 andInsanity:0];
        [self.scene.view presentScene: newScene transition: reveal];
    }
    else {

        [self.data setObject: @1 forKey:@"Tutorial"];
        [[PlistManager sharedManager] writeFileWith: self.data];

        SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
        CutscenePrologue *newScene = [CutscenePrologue sceneWithSize: self.size];
        [self.scene.view presentScene: newScene transition: reveal];
    }
}

@end
