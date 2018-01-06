//
//  OrangePickup.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/5/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

//@protocol OrangePickupDelegate
//
//- (void) pickDidCollected;
//
//@end

@interface OrangePickup : SKSpriteNode

//@property (nonatomic, assign) id<OrangePickupDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
