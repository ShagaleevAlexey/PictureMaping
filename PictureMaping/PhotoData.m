//
//  PhotoData.m
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "PhotoData.h"

@implementation PhotoData

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _idPhoto = [[dict objectForKey:@"id"] stringValue];
        _photo_75 = [dict objectForKey:@"photo_75"];
        _photo_130 = [dict objectForKey:@"photo_130"];
        _photo_604 = [dict objectForKey:@"photo_604"];
        _photo_807 = [dict objectForKey:@"photo_807"];
        _photo_1280 = [dict objectForKey:@"photo_1280"];
        _latitude = [[dict objectForKey:@"lat"] floatValue];
        _longitude = [[dict objectForKey:@"long"] floatValue];
        
        if (_latitude && _longitude)
            _isPlaced = YES;
        else
            _isPlaced = NO;
    }
    
    return self;
}

- (NSString *)minimizedPhoto {
    if (_photo_75)
        return _photo_75;
    else
        if (_photo_130)
            return _photo_130;
        else
            if (_photo_604)
                return _photo_604;
            else
                if (_photo_807)
                    return _photo_807;
                else
                    if (_photo_1280)
                        return _photo_1280;
                    else
                        return @"";
}

- (NSString *)maximizedPhoto {
    if (_photo_1280)
        return _photo_1280;
    else
        if (_photo_807)
            return _photo_807;
        else
            if (_photo_604)
                return _photo_604;
            else
                if (_photo_130)
                    return _photo_130;
                else
                    if (_photo_75)
                        return _photo_75;
                    else
                        return @"";
}

- (NSString *)optimalImagesByWidth:(float)width {
    if (width <= 75)
        return _photo_75;
    else
        if (width <= 130)
            return _photo_130;
        else
            if (width <= 604)
                return _photo_604;
            else
                if (width <= 807)
                    return _photo_807;
                else
                    return _photo_1280;
}

@end