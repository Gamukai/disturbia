//
//  PauseLabel.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import "PauseLabel.h"

@implementation PauseLabel

+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    PauseLabel *pauseLabel = [[PauseLabel alloc] initWithParent: parentNode];
    [parentNode addChild: pauseLabel];
    return pauseLabel;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    if (self = [super init]) {
        self.fontSize = parentNode.frame.size.height * 0.1;
        self.fontColor = [UIColor colorWithRed:0.521569 green:0.768627 blue:0.254902 alpha:1];
        self.fontName = @"8BIT WONDER";
        self.position = CGPointMake(parentNode.frame.size.width / 2, parentNode.frame.size.height / 2);
        [self setZPosition: 100.0];
    }
    return self;
}

@end
