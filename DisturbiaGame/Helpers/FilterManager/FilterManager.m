//
//  FilterManager.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/8/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "FilterManager.h"

@interface FilterManager ()

@property (nonatomic, assign) SKEffectNode *effectNode;
@property (nonatomic, assign) NSInteger effectFamily;
@property (nonatomic, strong) NSArray *filters;

@end

@implementation FilterManager

- (instancetype) initWithEffectNode: (SKEffectNode *) node
{
    if (self = [super init])
    {
        _effectNode = node;
        _effectFamily = -1;
        _filters = [NSArray arrayWithObjects: @"0", @"CIPixellate", @"CISpotLight", @"CIColorPosterize", @"CISpotColor", @"CIColorInvert", nil];
    }
    return self;
}

- (void) filterWillChangeWithOriginValue: (NSInteger) originValue
{
    if (originValue > 80 && _effectFamily != 5)
        [self updateFilterWithEffectFamily: 5];
    else if (originValue > 60 && originValue < 81 && _effectFamily != 4)
        [self updateFilterWithEffectFamily: 4];
    else if (originValue > 40 && originValue < 61 && _effectFamily != 3)
        [self updateFilterWithEffectFamily: 3];
    else if (originValue > 25 && originValue < 41 && _effectFamily != 2)
        [self updateFilterWithEffectFamily: 2];
    else if (originValue > 10 && originValue < 26 && _effectFamily != 1)
        [self updateFilterWithEffectFamily: 1];
    else if(originValue < 11 && _effectFamily != 0)
        [self updateFilterWithEffectFamily: 0];
}

- (void) updateFilterWithEffectFamily: (NSInteger) effectFamily
{
    _effectFamily = effectFamily;
    [_effectNode setFilter: [CIFilter filterWithName: [NSString stringWithFormat:@"%@", _filters[effectFamily]]]];
}

@end
