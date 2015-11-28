//
//  UICollectionViewCell+UIImage.m
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "UICollectionViewCell+UIImage.h"
#import <objc/runtime.h>

static void *ImageViewPropertyKey = &ImageViewPropertyKey;

@implementation UICollectionViewCell (ImageView)

- (void)setupWithImage:(UIImage *)image {
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self setClipsToBounds:YES];
        [self addSubview:self.imageView];
    }
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setImage:image];
}

- (UIImageView *)imageView {
    return objc_getAssociatedObject(self, ImageViewPropertyKey);
}

- (void)setImageView:(UIImageView *)imageView {
    objc_setAssociatedObject(self, ImageViewPropertyKey, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
