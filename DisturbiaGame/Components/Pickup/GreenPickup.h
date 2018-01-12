//
//  Pickup.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/30/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "ContactListener.h"

@protocol GreenPickupDelegate

- (void) greenPickupDidCollected;

@end

@interface GreenPickup : SKSpriteNode <ContactListener>

@property (nonatomic, assign) id<GreenPickupDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode<GreenPickupDelegate> *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
