//
//  InsanityTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/10/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "InsanityTimer.h"

@implementation InsanityTimer

+ (instancetype) createNewInsanityTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<InsanityTimerDelegate>) delegate
{
    InsanityTimer* timer = [[InsanityTimer alloc] initWithCounter: counter andIntervalTopValue: topValue andIntervalBottomValue: bottomValue];
    timer.delegate = delegate;
    return timer;
}

- (void) eventDidOccurred
{
    if (_delegate) [_delegate insanityEventDidOccurredWithValue: super.counter];
}

- (NSInteger) getCounter
{
    return super.counter;
}

- (void) setCounter: (NSInteger) value
{
    super.counter = value;
}

@end
