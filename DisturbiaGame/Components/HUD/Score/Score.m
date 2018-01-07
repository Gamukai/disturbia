//
//  Score.m
//  DisturbiaGame
//
//  Created by Augusto Falcão on 1/7/18.
//  Copyright © 2018 Augusto Falcão. All rights reserved.
//

#import "Score.h"

@implementation Score

+ (instancetype) createNodeOnParent: (SKNode *) parentNode
{
    Score* score = [[Score alloc] initWithParent: parentNode];
    [parentNode addChild: score];
    return score;
}

- (instancetype) initWithParent: (SKNode *) parentNode
{
    self = [super initWithFontNamed: @"8BIT WONDER"];
    if (self) {
        self.fontSize = parentNode.frame.size.height * 0.07;
        self.fontColor = [UIColor colorWithRed:0.521569 green:0.768627 blue:0.254902 alpha:1];
        self.position = CGPointMake(parentNode.frame.size.width * 0.13, parentNode.frame.size.height - parentNode.frame.size.height * 0.2);
        self.text = [NSString stringWithFormat:@"0"];
        self.zPosition = 100;
    }
    return self;
}

- (void) setNewScoreValue: (NSInteger) scoreValue
{
    self.text = [NSString stringWithFormat: @"%ld", scoreValue];
}

@end
