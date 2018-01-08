//
//  GiantScientistTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "GiantScientistTimer.h"

@implementation GiantScientistTimer

+ (instancetype) createNewGiantScientistTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<GiantScientistTimerDelegate>) delegate
{
    GiantScientistTimer* timer = [[GiantScientistTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate giantScientistEventDidOccurred];
}

@end
