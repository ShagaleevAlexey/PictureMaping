//
//  UICollectionViewCell+UIImage.h
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (ImageView)

@property (strong, nonatomic) UIImageView *imageView;

- (void)setupWithImage:(UIImage *)image;

@end
