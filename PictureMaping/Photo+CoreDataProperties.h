//
//  Photo+CoreDataProperties.h
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idPhoto;
@property (nullable, nonatomic, retain) NSNumber *isPlaced;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *photo_75;
@property (nullable, nonatomic, retain) NSString *photo_130;
@property (nullable, nonatomic, retain) NSString *photo_604;
@property (nullable, nonatomic, retain) NSString *photo_807;
@property (nullable, nonatomic, retain) NSString *photo_1280;

@end

NS_ASSUME_NONNULL_END
