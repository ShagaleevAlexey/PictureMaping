//
//  UIImageView+CoreData.m
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "UIImageView+CoreData.h"

@implementation UIImageView (CoreData)

- (void)setImageWithURL:(NSURL *)url {
    if (url) {
        __weak __typeof(self) wself = self;
        
        NSURLSessionTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself setImage:[UIImage imageWithData:data]];
            });
        }];
        
        [downloadPhotoTask resume];
    }
}


#pragma mark - Core Data

- (void)checkExistPhotoDataByID:(NSString *)idPhoto {
    /*NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PhotosModel"];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"id = %@", idPhoto]];
    [request setFetchLimit:1];
    
    NSError *error;
    NSUInteger count = [_managedObjectContext countForFetchRequest:request error:&error];
    
    if (count == NSNotFound) {
        NSLog(@"Not found");
    }
    else {
        NSLog(@"Found");
    }*/
}

- (void)insertImage:(UIImage *)image {
    /*NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    [newManagedObject setValue:pd.idPhoto forKey:@"id"];
    [newManagedObject setValue:pd.photo_75 forKey:@"photo_75"];
    [newManagedObject setValue:pd.photo_130 forKey:@"photo_130"];
    [newManagedObject setValue:pd.photo_604 forKey:@"photo_604"];
    [newManagedObject setValue:pd.photo_807 forKey:@"photo_807"];
    [newManagedObject setValue:pd.photo_1280 forKey:@"photo_1280"];
    [newManagedObject setValue:[NSNumber numberWithBool:pd.isPlaced] forKey:@"isPlaced"];
    [newManagedObject setValue:[NSNumber numberWithFloat:pd.latitude] forKey:@"latitude"];
    [newManagedObject setValue:[NSNumber numberWithFloat:pd.longitude] forKey:@"longitude"];
    
    [self managedObjectContext];*/
}

- (void)saveManagedContext {
    /*NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }*/
}

@end
