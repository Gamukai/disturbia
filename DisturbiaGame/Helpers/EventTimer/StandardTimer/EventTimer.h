//
//  EventTimer.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EventTimer : NSObject

@property (nonatomic, assign) NSUInteger counter;
@property (nonatomic, assign) NSUInteger top;
@property (nonatomic, assign) NSUInteger bottom;

- (instancetype) initWithCounter: (NSUInteger) counter andIntervalTopValue: (NSUInteger) topValue andIntervalBottomValue: (NSUInteger) bottomValue;
- (void) setNewCounterValue: (NSUInteger) value;
- (void) update;
- (void) eventDidOccurred;

@end
