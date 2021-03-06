//
//  GameScene.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/19/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <SpriteKit/SpriteKit.h>
#import "MenuScene.h"
#import "DeathScene.h"
#import "Constants.h"
#import "Background.h"
#import "Ground.h"
#import "Hero.h"
#import "Scientist.h"
#import "GiantScientist.h"
#import "GreenPickup.h"
#import "OrangePickup.h"
#import "Score.h"
#import "InsanityBar.h"
#import "PauseLabel.h"
#import "PauseButton.h"
#import "PlistManager.h"
#import "ContactListener.h"
#import "GreenPickupTimer.h"
#import "OrangePickupTimer.h"
#import "ScientistTimer.h"
#import "GiantScientistTimer.h"
#import "AudioPlayerManager.h"
#import "FilterManager.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, PauseButtonDelegate, GroundDelegate, GreenPickupDelegate, OrangePickupDelegate, ScientistDelegate, GiantScientistDelegate, GreenPickupTimerDelegate, OrangePickupTimerDelegate, ScientistTimerDelegate, GiantScientistTimerDelegate, InsanityBarDelegate> {

}

@property (nonatomic, assign) NSUInteger inMiniPuzzle;

@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, assign) NSUInteger distance;
@property (nonatomic, strong) Score *scoreLabel;
@property (nonatomic, assign) NSUInteger insanity;
@property (nonatomic, strong) InsanityBar *insanityBar;
@property (nonatomic, strong) PauseLabel *pauseLabel;
@property (nonatomic, strong) GreenPickupTimer *greenPickupTimer;
@property (nonatomic, strong) OrangePickupTimer *orangePickupTimer;
@property (nonatomic, strong) ScientistTimer *scientistTimer;
@property (nonatomic, strong) GiantScientistTimer *giantScientistTimer;
@property (nonatomic, strong) AudioPlayerManager *audioManager;
@property (nonatomic, strong) FilterManager *filterManager;

- (instancetype)initWithSize:(CGSize)size andDistance:(NSNumber *)distance andInsanity:(NSNumber *)insanity;

@end

