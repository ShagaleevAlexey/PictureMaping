//
//  MCoordinates.h
//  PictureMaping
//
//  Created by Alexey on 11/22/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCoordinates : NSObject

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

- (instancetype)initWithLatitude:(float)latitude AndLongtitude:(float)longitude;

@end
