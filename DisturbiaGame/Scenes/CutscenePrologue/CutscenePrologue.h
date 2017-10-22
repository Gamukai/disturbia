//
//  CutscenePrologue.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <SpriteKit/SpriteKit.h>
//#import "GameScene.h"

@interface CutscenePrologue : SKScene

@property (nonatomic, strong) SKSpriteNode *background;

@property (nonatomic, strong) SKLabelNode *storyLabelPt1;
@property (nonatomic, strong) SKLabelNode *storyLabelPt2;
@property (nonatomic, strong) SKLabelNode *storyLabelPt3;
@property (nonatomic, strong) SKLabelNode *storyLabelPt4;

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, assign) NSUInteger clickCount;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
