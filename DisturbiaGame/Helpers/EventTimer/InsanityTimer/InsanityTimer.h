//
//  InsanityTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/9/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@protocol InsanityTimerDelegate

- (void) insanityEventDidOccurred;

@end

@interface InsanityTimer : EventTimer

@property (nonatomic, assign) id<InsanityTimerDelegate> delegate;

+ (instancetype) createNewInsanityTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<InsanityTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
