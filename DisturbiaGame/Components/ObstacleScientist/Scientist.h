//
//  ObstacleScientist.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "ContactListener.h"

@protocol ScientistDelegate

- (void) scientistDidContacted;

@end

@interface Scientist : SKSpriteNode <ContactListener>

@property (nonatomic, assign) id<ScientistDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;
- (instancetype) initWithParent: (SKNode *) parentNode;

@end
