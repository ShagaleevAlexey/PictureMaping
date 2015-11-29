//
//  ImageViewController.m
//  PictureMaping
//
//  Created by Alexey on 11/20/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "PhotoShowerViewController.h"
#import "MapPhotosViewController.h"
#import "UIImageView+CoreData.h"

static NSString * const MAPPHOTOSVC_ID = @"MapPhotosVC";

@interface PhotoShowerViewController()

@end

@implementation PhotoShowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
     _scrollView.backgroundColor = [UIColor blackColor];
    
    [_scrollView addSubview:_imageView];
    /*[_imageView sd_setImageWithURL:[NSURL URLWithString:_photoData.maximizedPhoto] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _scrollView.contentSize = _imageView.bounds.size;
        _scrollView.contentOffset = CGPointMake(0, 0);
        
        [self balanceImageAndZoom];
    }];*/
    
    __weak __typeof(self) wself = self;
    __weak UIImageView *wimageView = _imageView;
    __weak UIScrollView *wscrollView = _scrollView;
    
    [_imageView setImageWithURL:[NSURL URLWithString:_photoData.maximizedPhoto] Comleted:^(UIImageView *imageView, BOOL finished, UIImage *image) {
        wimageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        wscrollView.contentSize = wimageView.bounds.size;
        wscrollView.contentOffset = CGPointMake(0, 0);
        
        [wself balanceImageAndZoom];
    }];
    
    
    UITapGestureRecognizer *oneFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewOneFingerTapped:)];
    oneFingerTapRecognizer.numberOfTapsRequired = 1;
    oneFingerTapRecognizer.numberOfTouchesRequired = 1;
    
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scollViewDoubleFingerTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    
    
    [self.scrollView addGestureRecognizer:oneFingerTapRecognizer];
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    [oneFingerTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    if (_photoData.isPlaced) {
        UIBarButtonItem *toMapBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionRightBarButton)];
        
        self.navigationItem.rightBarButtonItem = toMapBarItem;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)balanceImageAndZoom {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat scaleWidth = screenSize.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = screenSize.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    //[UIImageView beginAnimations:@"SetFrame" context:nil];
    
    _imageView.frame = contentsFrame;
    
    //[UIImageView commitAnimations];
}

#pragma - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _scrollView.subviews.firstObject;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [UIImageView beginAnimations:@"" context:nil];

    [self centerScrollViewContents];
    
    [UIImageView commitAnimations];
}

#pragma - UITapGestureRecognizer

- (void)scrollViewOneFingerTapped:(UITapGestureRecognizer *)recognizer {
    [self.navigationController setNavigationBarHidden:!(self.navigationController.navigationBarHidden) animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"ScroolView Two Finger Tapped");
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (void)scollViewDoubleFingerTapped:(UITapGestureRecognizer *)recognizer {
    /*CGFloat scaleHeight = _scrollView.frame.size.height / self.scrollView.contentSize.height;
    
    if (scaleHeight != _scrollView.zoomScale)
        [_scrollView setZoomScale:scaleHeight animated:YES];
    else
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];*/
}

#pragma - UIBarButtonItem

- (void)actionRightBarButton {
    MapPhotosViewController *mapPhotosVC = [self.storyboard instantiateViewControllerWithIdentifier:MAPPHOTOSVC_ID];
    
    [mapPhotosVC setMarkersCoordinatesByPhotosData:@[_photoData]];
    [mapPhotosVC setSelectedMarkerIndex:0];
    [self.navigationController pushViewController:mapPhotosVC animated:YES];
}

@end
