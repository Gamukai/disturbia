//
//  GameScene.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/19/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

#pragma mark - Scene Cycle

- (instancetype)initWithSize:(CGSize)size andDistance:(NSNumber *)distance andInsanity:(NSNumber *)insanity
{
    if (self = [super initWithSize:size]) {
        self.inMiniPuzzle = 0;

        self.distance = [distance integerValue];
        self.insanity = [insanity integerValue];

        self.data = [[PlistManager sharedManager] readFile];

        self.countJump = 0;
        self.insanityFamily = 0;

        [self.physicsWorld setContactDelegate: self];
        [self setShouldEnableEffects:YES];

        [self setup];
    }
    return self;
}

#pragma mark - Life cycle methods

- (void) didMoveToView:(SKView *)view
{
    self.data = [[PlistManager sharedManager] readFile];
    NSLog(@"%@", self.data);

    self.distance = [[self.data objectForKey:@"Distance"] integerValue];

    self.insanity = [self maxBetween:0 and:[[self.data objectForKey:@"Insanity"] integerValue]];
    [self modifyInsanity];

    [self play];
}

- (void)update:(CFTimeInterval)currentTime
{
    [self modifyDistance];
    [self modifyInsanity];
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.hero jump:self.countJump andParent:self];
    self.countJump++;
}

#pragma mark - Creators

- (void)setup
{
    [self createWorld];
    [self createInsanityBar];
    [self createScoreLabel];
    [self createHero];
    [self createGround];
    [self createEnemy];
    [self createFX];
    [self createPause];
    [self resetStoredValues];
}

- (void) createInsanityBar
{
    self.insanityBar = [[InsanityBar alloc] initWithParent: self];
    [self.insanityBar setZPosition: 100.00];
    [self addChild: self.insanityBar];
}

- (void)createFX
{
    self.visualFX = [NSArray arrayWithObjects: @"CIPixellate", @"CISpotLight", @"CIColorPosterize", @"CISpotColor", @"CIColorInvert", nil];
}

- (void)createScoreLabel
{
    self.distanceLabel = [[SKLabelNode alloc] initWithFontNamed:@"8BIT WONDER"];
    self.distanceLabel.fontSize = self.frame.size.height * 0.07;
    self.distanceLabel.fontColor = [UIColor colorWithRed:0.521569 green:0.768627 blue:0.254902 alpha:1];
    [self.distanceLabel setPosition:CGPointMake(self.frame.size.width * 0.13, self.frame.size.height - self.frame.size.height * 0.2)];
    [self.distanceLabel setText:[NSString stringWithFormat:@"%ld", (unsigned long) self.distance]];
    [self.distanceLabel setZPosition: 100];
    [self addChild: self.distanceLabel];
}

- (void)createWorld
{
    [Ground addNewNodeBackgroundTo: self];

    self.pauseButton = [[PauseButton alloc] initWithSize:CGSizeMake(self.frame.size.width * 0.06, self.frame.size.width * 0.06) position:CGPointMake(self.frame.size.width - self.frame.size.width * 0.02 - (self.frame.size.width * 0.03), self.frame.size.height - self.frame.size.height * 0.1 - (self.frame.size.width * 0.06) / 2 + self.frame.size.height * 0.025)];
    [self.pauseButton setZPosition: 100];
    self.pauseButton.delegate = self;
    [self addChild: self.pauseButton];

    SKTexture *textureInsanity = [SKTexture textureWithImageNamed:@"insanity-bar-filled"];
    SKSpriteNode *layerInsanity = [SKSpriteNode spriteNodeWithTexture:textureInsanity size:CGSizeMake(self.frame.size.width * 0.5, self.frame.size.height * 0.06)];
    layerInsanity.anchorPoint = CGPointMake(1.0, 0.0);
    layerInsanity.position = CGPointMake(self.frame.size.width * 0.53, self.frame.size.height - self.frame.size.height * 0.1);
    layerInsanity.zPosition = 50.0;
    [self addChild: layerInsanity];

    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, -3);
}

- (void) createHero
{
    self.hero = [Hero createNodeOn:self];
    self.hero.position = CGPointMake(self.frame.size.width / 6, self.frame.size.height / 4 + self.frame.size.height / 2);
    self.hero.zPosition = 100;
}

- (void)createGround
{
    [Ground addNewNodeTo:self];
}

- (void)createPause
{
    self.pauseLabel = [[PauseLabel alloc] initWithPosition:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) fontSize:self.frame.size.height * 0.1];

    [self addChild: self.pauseLabel];
}

- (void)resetStoredValues
{
    [self.data setObject: @0 forKey:@"Points"];
    [self.data setObject: @0 forKey:@"Insanity"];
    [self.data setObject: @0 forKey:@"Distance"];

    [[PlistManager sharedManager] writeFileWith: self.data];
}

#pragma mark - Actions

- (void)setPlayerWith:(NSURL *)url
{
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
}

- (void)changeFX
{
    if (self.insanity > 80 && self.insanityFamily != 6)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[4]]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"5" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 6;
    }
    else if (self.insanity > 60 && self.insanity < 81 && self.insanityFamily != 5)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[3]]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"4" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 5;
    }
    else if (self.insanity > 40 && self.insanity < 61 && self.insanityFamily != 4)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[2]]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"3" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 4;
    }
    else if (self.insanity > 25 && self.insanity < 41 && self.insanityFamily != 3)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[1]]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"2" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 3;
    }
    else if (self.insanity > 10 && self.insanity < 26 && self.insanityFamily != 2)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[0]]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"1" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 2;
    }
    else if(self.insanity < 11 && self.insanityFamily != 1)
    {
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"0"]]];

        NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: @"0" ofType:@"wav"]];
        [self setPlayerWith: url];

        self.insanityFamily = 1;
    }
}

- (void)createEnemy
{
    if (self.distance < 1000)
        self.obstacleTimer = [NSTimer scheduledTimerWithTimeInterval: 2.5 + ((arc4random() % 10) / 10.0) target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
    else if (self.distance < 2000)
        self.obstacleTimer = [NSTimer scheduledTimerWithTimeInterval: 1.5 + ((arc4random() % 20) / 10.0) target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
    else
        self.obstacleTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 + ((arc4random() % 30) / 10.0) target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
}

- (void)addEnemy
{
    int sort = arc4random()%3;

    if (sort == 0)
        [ObstacleScientist addNewCrazyNodeTo:self];
    else
        [ObstacleScientist addNewNodeTo:self];
}

- (void)die
{
    [self resetStoredValues];

    [self.audioPlayer stop];
    self.audioPlayer = nil;

    [self.obstacleTimer invalidate];

    SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
    DeathScene *newScene = [DeathScene sceneWithSize: self.size];
    [self.scene.view presentScene: newScene transition: reveal];
}

#pragma mark - Score and Death

- (void)modifyDistance
{
    self.distance++;
    [self.distanceLabel setText:[NSString stringWithFormat:@"%ld", (unsigned long)self.distance]];
}

- (void)modifyInsanity
{
    if (self.insanity >= 100) [self die];
    else if (self.auxInsanity % 50 == 49)
    {
        self.auxInsanity = 0;
        self.insanity++;
        [self changeFX];
        [self.insanityBar setProgress: self.insanity];
    }
    else self.auxInsanity++;
}

- (NSInteger)calculatePoints
{
    return 2 + [[NSNumber numberWithDouble:(self.distance / 1000)] integerValue];
}

- (NSInteger)maxBetween:(NSInteger)a and:(NSInteger)b
{
    return a > b ? a : b;
}

#pragma mark - SKPhysicsContactDelegate

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (heroType | pipeType))
    {
        [contact.bodyB.node removeFromParent];

        NSInteger points = [self calculatePoints];

        [self.obstacleTimer invalidate];
        [self setPaused: YES];

        // MANIPULATE DATA ACROSS SCENES !!!

        [self.data setObject:[NSNumber numberWithInteger: points] forKey:@"Points"];
        [self.data setObject:[NSNumber numberWithInteger: self.insanity] forKey:@"Insanity"];
        [self.data setObject:[NSNumber numberWithInteger: self.distance] forKey:@"Distance"];

        [[PlistManager sharedManager] writeFileWith: self.data];

        PuzzleScene *newScene = [PuzzleScene sceneWithSize: self.size];
        newScene.previousGameScene = self;
        [self.view presentScene: newScene];

        self.inMiniPuzzle = 1;

    }
    else if (collision == (heroType | terrainType))
    self.countJump = 0;
}

#pragma mark - DGPauseButtonDelegate

- (void) play
{
    self.obstacleTimer = [NSTimer scheduledTimerWithTimeInterval:3.4 target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
    [self.pauseLabel setText: @""];
    [self runAction: [SKAction playSoundFileNamed: [NSString stringWithFormat: @"tap"] waitForCompletion: NO]];
    [self setPaused: NO];

    [self.audioPlayer play];

    if (self.insanity > 80)
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[4]]]];
    else if (self.insanity > 60)
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[3]]]];
    else if (self.insanity > 40)
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[2]]]];
    else if (self.insanity > 25)
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[1]]]];
    else if (self.insanity > 10)
        [self setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", self.visualFX[0]]]];
    else
        [self setFilter: [CIFilter filterWithName: @""]];
}

- (void) pause
{
    [self runAction: [SKAction playSoundFileNamed: [NSString stringWithFormat: @"tap"] waitForCompletion: NO] completion:^{[self setPaused: YES];}];
    [self.obstacleTimer invalidate];
    self.pauseLabel.text = @"PAUSED";

    [self.audioPlayer pause];
}

@end
