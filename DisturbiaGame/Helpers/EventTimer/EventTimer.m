//
//  EventTimer.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@implementation EventTimer

- (instancetype) initWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue
{
    if (self = [super init])
    {
        _top = topValue;
        _bottom = bottomValue;
        _counter = counter;
    }
    return self;
}

- (void) setNewCounterValue: (NSUInteger) value
{
    _counter = value;
}

- (void) update
{
    _counter++;
    if (_counter % _top == _top - 1)
    {
        if (_top > _bottom) _top--;
        [self eventDidOccurred];
    }
}

- (void) eventDidOccurred
{

}

@end
