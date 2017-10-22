//
//  CutscenePrologue.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "CutscenePrologue.h"

@implementation CutscenePrologue

#pragma mark - Life Cycle

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    self.clickCount = 0;

    self.data = [NSMutableDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"data" ofType: @"plist"]];

    [self createWorld];
    [self createTextLabel];
}

#pragma mark - Creators

- (void)createWorld
{
    SKTexture *introBG = [SKTexture textureWithImageNamed: @"intro-bg"];
    self.background = [SKSpriteNode spriteNodeWithTexture: introBG size:self.frame.size];
    self.background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    self.background.zPosition = 0;
    [self addChild:self.background];

    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"0" ofType:@"wav"]];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
}

- (void)createTextLabel
{
    self.storyLabelPt1 = [[SKLabelNode alloc] init];
    self.storyLabelPt1.fontSize = self.frame.size.height * 0.07;
    self.storyLabelPt1.fontColor = [UIColor colorWithRed: (62.0/255.0) green: (80.0/255.0) blue: (44.0/255.0) alpha:1];
    self.storyLabelPt1.fontName = @"8BIT WONDER";
    [self.storyLabelPt1 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.75)];
    [self.storyLabelPt1 setZPosition: 100];
    [self.storyLabelPt1 setText:[NSString stringWithFormat:@"Project MKUltra"]];
    [self addChild: self.storyLabelPt1];

    self.storyLabelPt2 = [[SKLabelNode alloc] init];
    [self.storyLabelPt2 setHorizontalAlignmentMode: SKLabelHorizontalAlignmentModeCenter];
    self.storyLabelPt2.fontSize = self.frame.size.height * 0.04;
    self.storyLabelPt2.fontColor = [UIColor colorWithRed: (62.0/255.0) green: (80.0/255.0) blue: (44.0/255.0) alpha:1];
    self.storyLabelPt2.fontName = @"8BIT WONDER";
    [self.storyLabelPt2 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)];
    [self.storyLabelPt2 setZPosition: 100];
    [self.storyLabelPt2 setText:[NSString stringWithFormat:@"You are about to enter"]];
    [self addChild: self.storyLabelPt2];

    self.storyLabelPt3 = [[SKLabelNode alloc] init];
    [self.storyLabelPt3 setHorizontalAlignmentMode: SKLabelHorizontalAlignmentModeCenter];
    self.storyLabelPt3.fontSize = self.frame.size.height * 0.04;
    self.storyLabelPt3.fontColor = [UIColor colorWithRed: (62.0/255.0) green: (80.0/255.0) blue: (44.0/255.0) alpha:1];
    self.storyLabelPt3.fontName = @"8BIT WONDER";
    [self.storyLabelPt3 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.4)];
    [self.storyLabelPt3 setZPosition: 100];
    [self.storyLabelPt3 setText:[NSString stringWithFormat:@"CIA's Mind Control Program"]];
    [self addChild: self.storyLabelPt3];

    self.storyLabelPt4 = [[SKLabelNode alloc] init];
    [self.storyLabelPt4 setHorizontalAlignmentMode: SKLabelHorizontalAlignmentModeCenter];
    self.storyLabelPt4.fontSize = self.frame.size.height * 0.04;
    self.storyLabelPt4.fontColor = [UIColor colorWithRed: (62.0/255.0) green: (80.0/255.0) blue: (44.0/255.0) alpha:1];
    self.storyLabelPt4.fontName = @"8BIT WONDER";
    [self.storyLabelPt4 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.3)];
    [self.storyLabelPt4 setZPosition: 100];
    [self.storyLabelPt4 setText:[NSString stringWithFormat:@"Tap at your own risk_"]];
    [self addChild: self.storyLabelPt4];
}

#pragma mark - Api

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.clickCount == 0)
    {
        self.storyLabelPt1.fontSize = self.frame.size.height * 0.04;
        [self.storyLabelPt1 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.7)];
        [self.storyLabelPt2 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.6)];
        [self.storyLabelPt3 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)];
        [self.storyLabelPt4 setPosition:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.4)];
        [self.storyLabelPt1 setText:[NSString stringWithFormat:@"Name: Mikhail Zakhar"]];
        [self.storyLabelPt2 setText:[NSString stringWithFormat:@"ID: 41"]];
        [self.storyLabelPt3 setText:[NSString stringWithFormat:@"Origin: Saint Petersburg"]];
        [self.storyLabelPt4 setText:[NSString stringWithFormat:@"Status: Fugitive_"]];
        self.clickCount++;
    }
    else if (self.clickCount == 1)
    {
        [self.storyLabelPt1 removeFromParent];
        [self.storyLabelPt2 removeFromParent];
        [self.storyLabelPt3 removeFromParent];
        [self.storyLabelPt4 removeFromParent];

        SKTexture *tutorialBG1 = [SKTexture textureWithImageNamed: @"tutorial1"];
        self.background = [SKSpriteNode spriteNodeWithTexture: tutorialBG1 size:self.frame.size];
        self.background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
        self.background.zPosition = 2;
        [self addChild:self.background];

        self.clickCount++;
    }
    else if (self.clickCount == 2)
    {
        SKTexture *tutorialBG2 = [SKTexture textureWithImageNamed: @"tutorial2"];
        self.background = [SKSpriteNode spriteNodeWithTexture: tutorialBG2 size:self.frame.size];
        self.background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
        self.background.zPosition = 3;
        [self addChild:self.background];

        self.clickCount++;
    }
    else if (self.clickCount == 3)
    {
        SKTexture *tutorialBG3 = [SKTexture textureWithImageNamed: @"tutorial3"];
        self.background = [SKSpriteNode spriteNodeWithTexture: tutorialBG3 size:self.frame.size];
        self.background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
        self.background.zPosition = 4;
        [self addChild:self.background];

        self.clickCount++;
    }
    else
    {
        NSLog(@"%@", [self.data objectForKey: @"Tutorial"]);

        [self.data setObject:[NSNumber numberWithBool: YES] forKey:@"Tutorial"];
        [self.data writeToFile: [[NSBundle mainBundle] pathForResource: @"data" ofType:@"plist"] atomically:YES];

        NSLog(@"%@", [self.data objectForKey: @"Tutorial"]);

        SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
        //GameScene *newScene = [[GameScene alloc] initWithSize: self.size andDistance:0 andInsanity:0];
        //[self.scene.view presentScene: newScene transition: reveal];
    }
}
@end

