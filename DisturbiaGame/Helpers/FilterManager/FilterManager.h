//
//  FilterManager.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FilterManager : NSObject

- (instancetype) initWithEffectNode: (SKEffectNode *) node;

- (void) filterWillChangeWithOriginValue: (NSInteger) originValue;

@end
