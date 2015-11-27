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

@end
