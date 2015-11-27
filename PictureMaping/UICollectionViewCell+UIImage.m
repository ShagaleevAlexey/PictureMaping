//
//  UICollectionViewCell+UIImage.m
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "UICollectionViewCell+UIImage.h"

@implementation UICollectionViewCell_UIImage

- (instancetype)init {
    if (self = [super init]) {
        if (!_imageView)
            _imageView = [[UIImageView alloc] init];
        
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        //[_imageView setBackgroundColor:[UIColor redColor]];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (!_imageView) {
            _imageView = [[UIImageView alloc] initWithFrame:frame];
            [self addSubview:_imageView];
        }
        
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        //[_imageView setBackgroundColor:[UIColor redColor]];
    }
    
    return self;
}

- (void)setupWithImage:(UIImage *)image {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setImage:image];
}

@end
