//
//  PauseLabel.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PauseLabel.h"

@implementation PauseLabel

- (instancetype) initWithPosition:(CGPoint)position fontSize:(CGFloat)fontSize
{
    if (self = [super init])
    {
        self.fontSize = fontSize;
        self.fontColor = [UIColor colorWithRed:0.521569 green:0.768627 blue:0.254902 alpha:1];
        self.fontName = @"8BIT WONDER";
        [self setPosition: position];
        [self setZPosition: 100.0];
    }
    return self;
}

@end
