//
//  InsanityTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/9/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "InsanityHelperTimer.h"

@implementation InsanityHelperTimer

+ (instancetype) createNewInsanityHelperTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<InsanityHelperTimerDelegate>) delegate
{
    InsanityHelperTimer* timer = [[InsanityHelperTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate insanityHelperEventDidOccurred];
}

@end
