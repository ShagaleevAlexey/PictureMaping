//
//  MapPhotosViewController.m
//  PictureMaping
//
//  Created by Alexey on 11/20/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "MapPhotosViewController.h"
#import "PhotoData.h"
#import "MarkerInfoView.h"
#import "PhotoShowerViewController.h"

static NSString * const IMAGEVC_ID = @"ImageVC";

@interface MapPhotosViewController ()

@end

@implementation MapPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.1523458f longitude:61.2684895f zoom:6];
    
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //_mapView.myLocationEnabled = YES;
    _mapView.delegate = self;
    self.view = _mapView;
    
    if (_markersCoordinates) {
        for (int i = 0; i < _markersCoordinates.count; i++) {
            PhotoData *pd = [_markersCoordinates objectAtIndex:i];
            GMSMarker *marker = [[GMSMarker alloc] init];
             
            marker.position = CLLocationCoordinate2DMake(pd.latitude, pd.longitude);
            marker.title = @"Title";
            marker.zIndex = i;
            marker.map = _mapView;
        }
        
        if ((_selectedMarkerIndex >= 0) && (_selectedMarkerIndex < _markersCoordinates.count)) {
            PhotoData *pd = [_markersCoordinates objectAtIndex:_selectedMarkerIndex];
            
            [_mapView animateToLocation:CLLocationCoordinate2DMake(pd.latitude, pd.longitude)];
            [_mapView animateToZoom:15];
        }
    }
}

- (void)setMarkersCoordinatesByPhotosData:(NSArray *)photosData {
    NSMutableArray *newArray = [NSMutableArray array];
    int count = 0;

    for (PhotoData *pd in photosData) {
        if (pd.isPlaced) {
            [newArray addObject:pd];
            count++;
        }
    }
    
    _selectedMarkerIndex = -1;
    _markersCoordinates = [NSArray arrayWithArray:newArray];
}

#pragma - GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    MarkerInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"MarkerInfoWindow" owner:self options:nil] objectAtIndex:0];
    PhotoData *data = [_markersCoordinates objectAtIndex:marker.zIndex];
    
    //[infoView.imageView sd_setImageWithURL:[NSURL URLWithString:[data optimalImagesByWidth:infoView.imageView.bounds.size.width]]];
    
    return infoView;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    PhotoData *data = [_markersCoordinates objectAtIndex:marker.zIndex];
    
    PhotoShowerViewController *imageVC = [self.storyboard instantiateViewControllerWithIdentifier:IMAGEVC_ID];
    
    [imageVC setPhotoData:data];
    [self.navigationController pushViewController:imageVC animated:YES];
}

@end
