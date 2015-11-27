//
//  ImageViewController.h
//  PictureMaping
//
//  Created by Alexey on 11/20/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoData.h"

@interface PhotoShowerViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) PhotoData *photoData;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end
