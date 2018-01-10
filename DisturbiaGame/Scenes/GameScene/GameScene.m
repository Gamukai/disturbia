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

    [self play];
}

- (void)update:(CFTimeInterval)currentTime
{
    [_scoreLabel update];
    [_insanityHelperTimer update];

    [_orangePickupTimer update];
    [_scientistTimer update];
    [_giantScientistTimer update];
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_hero jumpWithParent: self];
}

#pragma mark - Creators

- (void)setup
{
    [self createWorld];
    [self createHUD];
    [self createHero];
    [self createTimers];
    [self createManagers];
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

    _scoreLabel = [Score createNodeOnParent: self];

    [PauseButton createNodeOnParent: self];
    _pauseLabel = [PauseLabel createNodeOnParent: self];
}

- (void) createHero
{
    self.hero = [Hero createNodeOn:self];
    self.hero.position = CGPointMake(self.frame.size.width / 6, self.frame.size.height / 4 + self.frame.size.height / 2);
    self.hero.zPosition = 100;
}

- (void) createTimers
{
    _orangePickupTimer = [OrangePickupTimer createNewOrangePickupTimerWithCounter: 0 andIntervalTopValue: 540 andIntervalBottomValue: 300 andDelegate: self];

    _scientistTimer = [ScientistTimer createNewScientistTimerWithCounter: 0 andIntervalTopValue: 200 andIntervalBottomValue: 90 andDelegate: self];
    _giantScientistTimer = [GiantScientistTimer createNewGiantScientistTimerWithCounter: 0 andIntervalTopValue: 300 andIntervalBottomValue: 120 andDelegate: self];

    _insanityTimer = [InsanityTimer createNewInsanityTimerWithCounter: 0 andIntervalTopValue: 1 andIntervalBottomValue: 1 andDelegate: self];
    _insanityHelperTimer = [InsanityHelperTimer createNewInsanityHelperTimerWithCounter: 0 andIntervalTopValue: 50 andIntervalBottomValue: 50 andDelegate: self];
}

- (void) createManagers
{
    _audioManager = [[AudioPlayerManager alloc] init];

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

- (void) checkInsanityStateWithInsanity: (NSInteger) insanity
{
    insanity > 99 ? [self die] : [self updateInsanityStateWithInsanity: insanity];
}

- (void) updateInsanityStateWithInsanity: (NSInteger) insanity
{
        [_audioManager audioWillChangeWithOriginValue: insanity];
        [_filterManager filterWillChangeWithOriginValue: insanity];
        [_insanityBar setProgress: insanity];
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
    [_hero resetJumpCounter];
}

#pragma mark - Orange Pickup Delegate

- (void) orangePickupDidCollected
{
    [_insanityTimer setCounter: [_insanityTimer getCounter] - 15];
}

#pragma mark - Scientist Delegate

- (void) scientistDidContacted
{
    [_insanityTimer setCounter: [_insanityTimer getCounter] + 20];
}

#pragma mark - Giant Scientist Delegate

- (void) giantScientistDidContacted
{
    [_insanityTimer setCounter: [_insanityTimer getCounter] + 40];
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

#pragma mark - Insanity Timer Delegate

- (void) insanityEventDidOccurredWithValue: (NSInteger) value
{
    [self checkInsanityStateWithInsanity: value];
}

#pragma mark - Insanity Helper Timer Delegate

- (void) insanityHelperEventDidOccurred
{
    [_insanityTimer update];
}

@end
