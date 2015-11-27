//
//  Photo.m
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (void)loadDataFromPhotoData:(PhotoData *)pd {
    self.idPhoto = [NSString stringWithString:pd.idPhoto];
    self.photo_75 = pd.photo_75;
    self.photo_130 = pd.photo_130;
    self.photo_604 = pd.photo_604;
    self.photo_807 = pd.photo_807;
    self.photo_1280 = pd.photo_1280;
    self.isPlaced = [NSNumber numberWithBool:pd.isPlaced];
    self.latitude = [NSNumber numberWithFloat:pd.latitude];
    self.longitude = [NSNumber numberWithFloat:pd.longitude];
}

- (NSString *)minimizedPhoto {
    if (self.photo_75)
        return self.photo_75;
    else
        if (self.photo_130)
            return self.photo_130;
        else
            if (self.photo_604)
                return self.photo_604;
            else
                if (self.photo_807)
                    return self.photo_807;
                else
                    if (self.photo_1280)
                        return self.photo_1280;
                    else
                        return @"";
}

- (NSString *)maximizedPhoto {
    if (self.photo_1280)
        return self.photo_1280;
    else
        if (self.photo_807)
            return self.photo_807;
        else
            if (self.photo_604)
                return self.photo_604;
            else
                if (self.photo_130)
                    return self.photo_130;
                else
                    if (self.photo_75)
                        return self.photo_75;
                    else
                        return @"";
}

- (NSString *)optimalImagesByWidth:(float)width {
    if (width <= 75)
        return self.photo_75;
    else
        if (width <= 130)
            return self.photo_130;
        else
            if (width <= 604)
                return self.photo_604;
            else
                if (width <= 807)
                    return self.photo_807;
                else
                    return self.photo_1280;
}

@end
