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
    [self setImageWithURL:url Comleted:nil];
}

- (void)setImageWithURL:(NSURL *)url Comleted:(void (^)(UIImageView *imageView, BOOL finished, UIImage *image))completed {
    if (url) {
        __weak __typeof(self) wself = self;
        __weak __typeof(url) wurl = url;
        
        NSLog(@"Start block: %@", [[NSThread currentThread] description]);
        NSURLSessionTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            PhotoCache *photoCache = [[PhotoCache MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"url contains[c] %@", wurl.absoluteString]] firstObject];
            
            if (photoCache != nil && photoCache.photo != nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:photoCache.photo];
                    
                    [wself setImage:image];
                    NSLog(@"Get photo: %f %@ ", (float)photoCache.photo.length/1024.0f/1024.0f, photoCache.url);
                    
                    if (completed != nil)
                        completed(self, YES, image);
                });
            }
            else {
                PhotoCache *newPhotoCache = [PhotoCache MR_createEntity];
                
                newPhotoCache.url = wurl.absoluteString;
                newPhotoCache.photo = [NSData dataWithContentsOfURL:location];
                NSLog(@"Download photo.");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:newPhotoCache.photo];
                    
                    [wself setImage:[UIImage imageWithData:newPhotoCache.photo]];
                    
                    if (completed != nil)
                        completed(wself, YES, image);
                });
                
                [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
            }
            NSLog(@"End block: %@", [[NSThread currentThread] description]);
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
