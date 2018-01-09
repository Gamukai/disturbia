//
//  ScoreTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "ScoreTimer.h"

@implementation ScoreTimer

+ (instancetype) createNewScoreTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<ScoreTimerDelegate>) delegate
{
    ScoreTimer* timer = [[ScoreTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate scoreEventDidOccurredWithScore: super.counter];
}

@end
