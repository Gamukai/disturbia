//
//  PuzzleLight.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class PuzzleLight;

@protocol PuzzleLightDelegate <NSObject>

- (void) tapped;
- (void) died;

@end

@interface PuzzleLight : SKSpriteNode

@property (nonatomic, assign) id<PuzzleLightDelegate> delegate;
@property (nonatomic, assign) NSTimer *lifeTimer;

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position color:(NSString *)color lifeTime:(NSTimeInterval)lifeTime;

@end
