//
//  AudioPlayerManager.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "AudioPlayerManager.h"

@interface AudioPlayerManager ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) NSInteger audioFamily;

@end

@implementation AudioPlayerManager

- (instancetype) init
{
    if (self = [super init])
    {
        _audioFamily = -1;
    }
    return self;
}

- (void) audioWillChangeWithOriginValue: (NSInteger) originValue
{
    if (originValue > 80 && _audioFamily != 5)
        [self updateAudioWithFamily: 5];
    else if (originValue > 60 && originValue < 81 && _audioFamily != 4)
        [self updateAudioWithFamily: 4];
    else if (originValue > 40 && originValue < 61 && _audioFamily != 3)
        [self updateAudioWithFamily: 3];
    else if (originValue > 25 && originValue < 41 && _audioFamily != 2)
        [self updateAudioWithFamily: 2];
    else if (originValue > 10 && originValue < 26 && _audioFamily != 1)
        [self updateAudioWithFamily: 1];
    else if(originValue < 11 && _audioFamily != 0)
        [self updateAudioWithFamily: 0];
}

- (void) updateAudioWithFamily: (NSInteger) audioFamily
{
    _audioFamily = audioFamily;

    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle]  pathForResource: [NSString stringWithFormat:@"%ld", audioFamily] ofType:@"wav"]];
    [self setPlayerWith: url];
}

- (void) setPlayerWith: (NSURL *) url
{
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: nil];
    _audioPlayer.numberOfLoops = -1;
    [self play];
}

- (void) play
{
    [_audioPlayer play];
}

- (void) pause
{
    [_audioPlayer pause];
}

- (void) stop
{
    [_audioPlayer stop];
    _audioPlayer = nil;
}

@end
