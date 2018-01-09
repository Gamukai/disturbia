//
//  GameScene.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/19/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "GameScene.h"
#import "ContactListener.h"

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

    self.distance = [[self.data objectForKey:@"Distance"] integerValue];

    self.insanity = [self maxBetween:0 and:[[self.data objectForKey:@"Insanity"] integerValue]];
    [self modifyInsanity];

    [self play];
}

- (void)update:(CFTimeInterval)currentTime
{
    [_orangePickupTimer update];
    [_scientistTimer update];
    [_giantScientistTimer update];

    [_scoreTimer update];
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
    [self createHUD];
    [self createHero];
    [self createPickupTimer];
    [self createScientistTimer];
    [self createGiantScientistTimer];
    [self createScoreTimer];
    [self createAudioManager];
    [self createFilterManager];
    [self resetStoredValues];
}

- (void)createWorld
{
    [Background addNewNodeBackgroundTo: self];
    [Ground createNodeOnParent: self];

    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, -3);
}

- (void) createHUD
{
    _insanityBar = [InsanityBar createNodeOnParent: self];

    _distanceLabel = [Score createNodeOnParent: self];

    [PauseButton createNodeOnParent: self];
    _pauseLabel = [PauseLabel createNodeOnParent: self];
}

- (void) createHero
{
    self.hero = [Hero createNodeOn:self];
    self.hero.position = CGPointMake(self.frame.size.width / 6, self.frame.size.height / 4 + self.frame.size.height / 2);
    self.hero.zPosition = 100;
}

- (void) createPickupTimer
{
    _orangePickupTimer = [OrangePickupTimer createNewOrangePickupTimerWithCounter: 0 andIntervalTopValue: 540 andIntervalBottomValue: 300 andDelegate: self];
}

- (void) createScientistTimer
{
    _scientistTimer = [ScientistTimer createNewScientistTimerWithCounter: 0 andIntervalTopValue: 200 andIntervalBottomValue: 90 andDelegate: self];
}

- (void) createGiantScientistTimer
{
    _giantScientistTimer = [GiantScientistTimer createNewGiantScientistTimerWithCounter: 0 andIntervalTopValue: 300 andIntervalBottomValue: 120 andDelegate: self];
}

- (void) createScoreTimer
{
    _scoreTimer = [ScoreTimer createNewScoreTimerWithCounter: 0 andIntervalTopValue: 1 andIntervalBottomValue: 1 andDelegate: self];
}

- (void) createAudioManager
{
    _audioManager = [[AudioPlayerManager alloc] init];
}

- (void) createFilterManager
{
    _filterManager = [[FilterManager alloc] initWithEffectNode: self];
}

- (void)resetStoredValues
{
    [self.data setObject: @0 forKey:@"Points"];
    [self.data setObject: @0 forKey:@"Insanity"];
    [self.data setObject: @0 forKey:@"Distance"];

    [[PlistManager sharedManager] writeFileWith: self.data];
}

#pragma mark - Actions

- (void)die
{
    [self resetStoredValues];

    [_audioManager stop];

    SKTransition *reveal = [SKTransition fadeWithDuration:.5f];
    DeathScene *newScene = [DeathScene sceneWithSize: self.size];
    [self.scene.view presentScene: newScene transition: reveal];
}

#pragma mark - Score and Death

- (void) modifyInsanity
{
    if (self.insanity >= 100) [self die];
    else if (self.auxInsanity % 50 == 49)
    {
        self.auxInsanity = 0;
        self.insanity++;
        [_audioManager audioWillChangeWithOriginValue: _insanity];
        [_filterManager filterWillChangeWithOriginValue: _insanity];
        [self.insanityBar setProgress: self.insanity];
    }
    else self.auxInsanity++;
}

- (NSInteger)maxBetween:(NSInteger)a and:(NSInteger)b
{
    return a > b ? a : b;
}

#pragma mark - Physics Contact Delegate

- (void) didBeginContact: (SKPhysicsContact *) contact
{
    [(id<ContactListener>) contact.bodyA.node didBeginContact: contact];
    [(id<ContactListener>) contact.bodyB.node didBeginContact: contact];
}

- (void) didEndContact: (SKPhysicsContact *) contact
{
    [(id<ContactListener>) contact.bodyA.node didEndContact: contact];
    [(id<ContactListener>) contact.bodyB.node didEndContact: contact];
}

#pragma mark - Pause Button Delegate

- (void) play
{
    [self runAction: [SKAction playSoundFileNamed: [NSString stringWithFormat: @"tap"] waitForCompletion: NO]];
    [_pauseLabel setText: @""];

    [self setPaused: NO];
    [self setUserInteractionEnabled:YES];
    [_audioManager play];
}

- (void) pause
{
    [self runAction: [SKAction playSoundFileNamed: [NSString stringWithFormat: @"tap"] waitForCompletion: NO] completion:^{[self setPaused: YES];}];
    _pauseLabel.text = @"PAUSED";

    [self setUserInteractionEnabled:NO];
    [_audioManager pause];
}

#pragma mark - Ground Delegate

- (void) groundDidTouched
{
    _countJump = 0;
}

#pragma mark - Orange Pickup Delegate

- (void) orangePickupDidCollected
{
    _insanity = [self maxBetween: 0 and: _insanity - 15];
    [self modifyInsanity];
}

#pragma mark - Scientist Delegate

- (void) scientistDidContacted
{
    _insanity = _insanity + 20;
    [self modifyInsanity];
}

#pragma mark - Giant Scientist Delegate

- (void) giantScientistDidContacted
{
    _insanity = _insanity + 40;
    [self modifyInsanity];
}

#pragma mark - Orange Picker Timer Delegate

- (void) orangePickupEventDidOccurred
{
    [OrangePickup createNodeOnParent: self];
}

#pragma mark - Scientist Timer Delegate

- (void) scientistEventDidOccurred
{
    [Scientist createNodeOnParent: self];
}

#pragma mark - Giant Scientist Timer Delegate

- (void) giantScientistEventDidOccurred
{
    [GiantScientist createNodeOnParent: self];
}

#pragma mark - Score Timer Delegate

- (void) ScoreEventDidOccurredWithScore: (NSInteger) score
{
    [_distanceLabel setNewScoreValue: score];
}

@end
