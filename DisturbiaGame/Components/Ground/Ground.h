//
//  Ground.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "ContactListener.h"

@protocol GroundDelegate <NSObject>

- (void) groundDidTouched;

@end

@interface Ground : SKSpriteNode <ContactListener>

@property (nonatomic, strong) id<GroundDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode *) parentNode;
- (instancetype) initWithParent: (SKNode *) parentNode;

@end
