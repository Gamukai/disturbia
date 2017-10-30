//
//  Constants.h
//  DisturbiaGame
//
//  Created by Augusto Falcão on 10/20/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

#ifndef DGConstants_h
#define DGConstants_h

typedef NS_OPTIONS(NSUInteger, CollisionCategory) {
    heroType    = (1 << 0),
    terrainType = (1 << 1),
    pipeType    = (1 << 2),
    pickupType  = (1 << 3)
};

#endif /* Constants_h */
