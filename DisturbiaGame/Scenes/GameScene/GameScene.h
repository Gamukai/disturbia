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
#import "PuzzleScene.h"
#import "DeathScene.h"
#import "Constants.h"
#import "Background.h"
#import "Ground.h"
#import "Hero.h"
#import "Scientist.h"
#import "GiantScientist.h"
#import "OrangePickup.h"
#import "InsanityBar.h"
#import "PauseLabel.h"
#import "PauseButton.h"
#import "PlistManager.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, PauseButtonDelegate>{

}

@property (nonatomic, assign) NSUInteger inMiniPuzzle;

@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, assign) NSUInteger distance;
@property (nonatomic, strong) SKLabelNode *distanceLabel;
@property (nonatomic, assign) NSUInteger insanity;
@property (nonatomic, assign) NSUInteger insanityFamily;
@property (nonatomic, assign) NSUInteger auxInsanity;
@property (nonatomic, strong) InsanityBar *insanityBar;
@property (nonatomic, strong) PauseLabel *pauseLabel;
@property (nonatomic, strong) NSTimer *pickupTimer;
@property (nonatomic, strong) NSTimer *obstacleTimer;
@property (nonatomic, strong) PauseButton *pauseButton;
@property (nonatomic, assign) NSUInteger countJump;
@property (nonatomic, strong) NSArray *visualFX;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (instancetype)initWithSize:(CGSize)size andDistance:(NSNumber *)distance andInsanity:(NSNumber *)insanity;

@end

