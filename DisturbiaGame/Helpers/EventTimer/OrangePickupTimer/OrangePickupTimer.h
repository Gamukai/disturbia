//
//  OrangePickupTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventTimer.h"

@protocol OrangePickupTimerDelegate

- (void) orangePickupEventDidOccurred;

@end

@interface OrangePickupTimer : EventTimer

@property (nonatomic, assign) id<OrangePickupTimerDelegate> delegate;

+ (instancetype) createNewOrangePickupTimerWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue andDelegate: (id<OrangePickupTimerDelegate>) delegate;

- (void) eventDidOccurred;

@end
