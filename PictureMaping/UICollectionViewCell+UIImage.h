//
//  UICollectionViewCell+UIImage.h
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell_UIImage : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setupWithImage:(UIImage *)image;

@end
