//
//  GreenPickupTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/11/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventTimer.h"

@protocol GreenPickupTimerDelegate

- (void) greenPickupEventDidOccurred;

@end

@interface GreenPickupTimer : EventTimer

@property (nonatomic, assign) id<GreenPickupTimerDelegate> delegate;

+ (instancetype) createNewGreenPickupTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<GreenPickupTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
