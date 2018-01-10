//
//  InsanityTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/9/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@protocol InsanityHelperTimerDelegate

- (void) insanityHelperEventDidOccurred;

@end

@interface InsanityHelperTimer : EventTimer

@property (nonatomic, assign) id<InsanityHelperTimerDelegate> delegate;

+ (instancetype) createNewInsanityHelperTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<InsanityHelperTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
