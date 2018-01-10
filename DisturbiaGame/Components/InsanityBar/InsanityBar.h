//
//  InsanityBar.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "InsanityTimer.h"
#import "InsanityHelperTimer.h"

@protocol InsanityBarDelegate

- (void) updateWithInsanity: (NSInteger) insanity;
- (void) maxValueUpdate;

@end

@interface InsanityBar : SKCropNode <InsanityTimerDelegate, InsanityHelperTimerDelegate>

@property (nonatomic, strong) id<InsanityBarDelegate> delegate;
@property (nonatomic, strong) InsanityTimer *insanityTimer;
@property (nonatomic, strong) InsanityHelperTimer *insanityHelperTimer;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
