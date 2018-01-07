//
//  GiantScientst.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/5/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "ContactListener.h"

@protocol GiantScientistDelegate

- (void) giantScientistDidContacted;

@end

@interface GiantScientist : SKSpriteNode <ContactListener>

@property (nonatomic, assign) id<GiantScientistDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;
- (instancetype) initWithParent: (SKNode *) parentNode;

@end
