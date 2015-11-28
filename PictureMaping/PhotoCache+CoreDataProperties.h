//
//  PhotoCache+CoreDataProperties.h
//  PictureMaping
//
//  Created by Alexey on 11/28/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCache (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idPhoto;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
