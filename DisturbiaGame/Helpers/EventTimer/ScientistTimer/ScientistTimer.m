//
//  ScientistTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "ScientistTimer.h"

@implementation ScientistTimer

+ (instancetype) createNewScientistTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<ScientistTimerDelegate>) delegate
{
    ScientistTimer* timer = [[ScientistTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate scientistEventDidOccurred];
}

@end
