//
//  OrangePickupTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "OrangePickupTimer.h"

@implementation OrangePickupTimer

+ (instancetype) createNewOrangePickupTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<OrangePickupTimerDelegate>) delegate
{
    OrangePickupTimer* timer = [[OrangePickupTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate orangePickupEventDidOccurred];
}

@end
