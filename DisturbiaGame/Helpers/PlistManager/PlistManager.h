//
//  PlistManager.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/19/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

+ (id) sharedManager;

- (NSMutableDictionary *) readFile;
- (void) writeFileWith: (NSMutableDictionary *)dictionary;

@end
