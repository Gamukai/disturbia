//
//  AudioPlayerManager.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

@import AVFoundation;
#import <Foundation/Foundation.h>

@interface AudioPlayerManager : NSObject

- (instancetype) init;

- (void) audioWillChangeWithOriginValue: (NSInteger) originValue;

- (void) play;
- (void) pause;
- (void) stop;

@end
