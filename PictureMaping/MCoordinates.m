//
//  MCoordinates.m
//  PictureMaping
//
//  Created by Alexey on 11/22/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "MCoordinates.h"

@implementation MCoordinates

- (instancetype)initWithLatitude:(float)latitude AndLongtitude:(float)longitude {
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

@end
