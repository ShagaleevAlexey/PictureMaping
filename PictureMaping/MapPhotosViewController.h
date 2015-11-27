//
//  MapPhotosViewController.h
//  PictureMaping
//
//  Created by Alexey on 11/20/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface MapPhotosViewController : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSArray *markersCoordinates;
@property (nonatomic) NSInteger selectedMarkerIndex;

- (void)setMarkersCoordinatesByPhotosData:(NSArray *)photosData;

@end
