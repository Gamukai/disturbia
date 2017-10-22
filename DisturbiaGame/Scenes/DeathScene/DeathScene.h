//
//  DeathScene.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/21/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <SpriteKit/SpriteKit.h>
#import "MenuScene.h"

@interface DeathScene : SKScene

@property (nonatomic, strong) SKLabelNode *deathLabel1;
@property (nonatomic, strong) SKLabelNode *deathLabel2;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
