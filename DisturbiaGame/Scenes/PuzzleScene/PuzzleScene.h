//
//  PuzzleScene.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "PuzzleLight.h"
#import "PlistManager.h"

@interface PuzzleScene : SKScene <PuzzleLightDelegate>

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, assign) NSUInteger parentInsanity;

@property (nonatomic, assign) NSUInteger numberOfLights;
@property (nonatomic, assign) NSUInteger createdLights;

@property (nonatomic, assign) NSUInteger clickCount;

@property SKScene *previousGameScene;

@end
