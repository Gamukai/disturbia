//
//  ContactListener.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/6/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#ifndef ContactListener_h
#define ContactListener_h

#endif /* ContactListener_h */

#import <SpriteKit/SpriteKit.h>

@protocol ContactListener <NSObject>

- (void) didBeginContact: (SKPhysicsContact *) contact;
- (void) didEndContact: (SKPhysicsContact *) contact;

@end
