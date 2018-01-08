//
//  ScoreTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "EventTimer.h"

@protocol ScoreTimerDelegate

- (void) ScoreEventDidOccurredWithScore: (NSInteger) score;

@end

@interface ScoreTimer : EventTimer

@property (nonatomic, assign) id<ScoreTimerDelegate> delegate;

+ (instancetype) createNewScoreTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<ScoreTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
