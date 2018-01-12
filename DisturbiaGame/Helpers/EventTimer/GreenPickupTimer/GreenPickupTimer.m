//
//  GreenPickupTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/11/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "GreenPickupTimer.h"

@implementation GreenPickupTimer

+ (instancetype) createNewGreenPickupTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<GreenPickupTimerDelegate>) delegate
{
    GreenPickupTimer* timer = [[GreenPickupTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate greenPickupEventDidOccurred];
}

@end
