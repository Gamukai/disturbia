//
//  GiantScientistTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@protocol GiantScientistTimerDelegate

- (void) giantScientistEventDidOccurred;

@end

@interface GiantScientistTimer : EventTimer

@property (nonatomic, assign) id<GiantScientistTimerDelegate> delegate;

+ (instancetype) createNewGiantScientistTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<GiantScientistTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
