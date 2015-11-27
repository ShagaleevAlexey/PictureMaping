//
//  Photo.h
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject

- (void)loadDataFromPhotoData:(PhotoData *)pd;
- (NSString *)minimizedPhoto;
- (NSString *)maximizedPhoto;
- (NSString *)optimalImagesByWidth:(float)width;

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
