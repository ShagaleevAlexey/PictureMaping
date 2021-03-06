//
//  UIImageView+CoreData.h
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UIImageView (CoreData)

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url Comleted:(void (^)(UIImageView *imageView, BOOL finished, UIImage *image))completed;
@end
