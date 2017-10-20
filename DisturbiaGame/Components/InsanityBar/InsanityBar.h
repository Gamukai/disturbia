//
//  InsanityBar.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface InsanityBar : SKCropNode

- (instancetype)initWithParent: (SKNode *) parentNode;
- (void) setProgress: (CGFloat) progress;

@end
