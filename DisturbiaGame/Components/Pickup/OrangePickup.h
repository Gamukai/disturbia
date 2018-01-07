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
#import "ContactListener.h"

@protocol OrangePickupDelegate

- (void) orangePickupDidCollected;

@end

@interface OrangePickup : SKSpriteNode <ContactListener>

@property (nonatomic, assign) id<OrangePickupDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
