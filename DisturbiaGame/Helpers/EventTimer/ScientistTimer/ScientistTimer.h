//
//  ScientistTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@protocol ScientistTimerDelegate

- (void) scientistEventDidOccurred;

@end

@interface ScientistTimer : EventTimer

@property (nonatomic, assign) id<ScientistTimerDelegate> delegate;

+ (instancetype) createNewScientistTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<ScientistTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
