//
//  MenuScene.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "CutscenePrologue.h"
#import "PlistManager.h"

@interface MenuScene : SKScene

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) SKLabelNode *startButton;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
