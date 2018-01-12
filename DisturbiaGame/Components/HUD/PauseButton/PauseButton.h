//
//  PauseButton.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class PauseButton;

@protocol PauseButtonDelegate <NSObject>

- (void) play;
- (void) pause;

@end

@interface PauseButton : SKSpriteNode

@property (weak) id<PauseButtonDelegate> delegate;

+ (instancetype) createNodeOnParent: (SKNode<PauseButtonDelegate> *) parentNode;

- (instancetype) initWithParent: (SKNode *) parentNode;

@end
