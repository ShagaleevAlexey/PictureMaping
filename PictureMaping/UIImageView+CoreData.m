//
//  UIImageView+CoreData.m
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "UIImageView+CoreData.h"
#import "PhotoCache.h"

@implementation UIImageView (CoreData)

- (void)setImageWithURL:(NSURL *)url {
    if (url) {
        __weak __typeof(self) wself = self;
        __weak __typeof(NSURL *) wurl = url;
        
        NSURLSessionTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            PhotoCache *photoCache = [[PhotoCache MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"url contains[c] %@", wurl.absoluteString]] firstObject];
            
            if (photoCache != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Get photo.");
                    [wself setImage:[UIImage imageWithData:photoCache.photo]];
                });
            }
            else {
                PhotoCache *newPhotoCache = [PhotoCache MR_createEntity];
                
                newPhotoCache.url = wurl.absoluteString;
                newPhotoCache.photo = [NSData dataWithContentsOfURL:location];
                NSLog(@"Download photo.");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself setImage:[UIImage imageWithData:newPhotoCache.photo]];
                });
                
                [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
            }
        }];
        
        [downloadPhotoTask resume];
    }
}


#pragma mark - Core Data

- (void)saveContext {
    /*[[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
        else
            NSLog(@"It`s not all!");
    }];*/
}

- (BOOL)checkExistPhotoDataByURL:(NSString *)url {
    NSArray *array = [PhotoCache MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"url contains[c] %@", url]];

    if (array.count == 0) {
        return NO;
    }
    else {
        return YES;
    }
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
