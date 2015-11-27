//
//  PhotoData.h
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoData : NSObject

@property (strong, nonatomic) NSString *idPhoto;
@property (strong, nonatomic) NSString *photo_75;
@property (strong, nonatomic) NSString *photo_130;
@property (strong, nonatomic) NSString *photo_604;
@property (strong, nonatomic) NSString *photo_807;
@property (strong, nonatomic) NSString *photo_1280;
@property (assign, nonatomic) BOOL isPlaced;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;


- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSString *)minimizedPhoto;
- (NSString *)maximizedPhoto;
- (NSString *)optimalImagesByWidth:(float)width;

@end
