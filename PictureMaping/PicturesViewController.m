//
//  PicturesViewController.m
//  PictureMaping
//
//  Created by Alexey on 11/15/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "PicturesViewController.h"
#import "UICollectionViewCell+UIImage.h"
#import "PhotoShowerViewController.h"
#import "UIImageView+CoreData.h"
#import "VKDataApi.h"
#import "PhotoData.h"
#import "Photo.h"
#import "MapPhotosViewController.h"

static NSString * const APP_ID = @"5149221";
static NSString * const GROUP_ID = @"27150137"; //@"-35115798";
static NSString * const VK_API_DOMAIN = @"domain";
static NSString * const CELL_ID = @"cell_id0";
static NSString * const IMAGEVC_ID = @"ImageVC";
static NSString * const MAPPHOTOSVC_ID = @"MapPhotosVC";
static NSString * const SEGUE_IMAGEVC_ID = @"segueTranferToImageVC";

@interface PicturesViewController ()

@end

@implementation PicturesViewController {
    NSMutableArray *photosFromWall;
    NSOperationQueue *operationQueue;
    NSInteger offsetPhotos;
}

- (void)viewDidLoad {
    [[VKSdk initializeWithAppId:APP_ID] registerDelegate:self];
    [super viewDidLoad];
    
    offsetPhotos = 0;
    photosFromWall = [[NSMutableArray alloc] init];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    
    [_refreshControl setTintColor:[UIColor grayColor]];
    [_refreshControl setClipsToBounds:YES];
    [_refreshControl setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin)];
    [_refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    
    //[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    
    [self.collectionView addSubview:_refreshControl];
    [self.collectionView setAlwaysBounceVertical:YES];
    
    operationQueue = [[NSOperationQueue alloc] init];
    NSOperation *loadPhotoData = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(loadPhotosWithOptions:)
                                                                        object:@{@"owner_id" : GROUP_ID, @"offset" : [NSNumber numberWithInteger:offsetPhotos], @"count" : [NSNumber numberWithInteger:70]}];
    
    [operationQueue addOperation:loadPhotoData];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Maps" style:UIBarButtonItemStyleDone target:self action:@selector(actionRightBarButton)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadPhotosWithOptions:(NSDictionary *)options {
    NSString *owner_id = [options objectForKey:@"owner_id"];
    NSInteger offset = [[options objectForKey:@"offset"] intValue];
    NSInteger count = [[options objectForKey:@"count"] intValue];
    
    if ((owner_id.length > 0) && (offset >= 0) && (count > 0)) {
        NSArray *newPhotos = [VKDataApi arrayPhotosFromVkJson:[self getPhotoGroupWithID:owner_id Offset:offset Count:count]];
        NSMutableArray *indexes = [NSMutableArray array];
        
        for (int i = 0; i < newPhotos.count; i++) {
            Photo *newPhoto = [Photo MR_createEntity];
            [newPhoto loadDataFromPhotoData:[newPhotos objectAtIndex:i]];
            [indexes addObject:[NSIndexPath indexPathForItem:i + photosFromWall.count inSection:0]];
        }
        
        [self saveContext];
        [photosFromWall performSelectorOnMainThread:@selector(addObjectsFromArray:) withObject:newPhotos waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(setOffsetPhotos:) withObject:[NSNumber numberWithInteger:offset + count] waitUntilDone:YES];
        [self.collectionView performSelectorOnMainThread:@selector(insertItemsAtIndexPaths:) withObject:indexes waitUntilDone:YES];
    }
}

- (NSDictionary *)getPhotoGroupWithID:(NSString *)ownerId Offset:(NSInteger)offset Count:(NSInteger)count {
    VKRequest *request = [VKRequest requestWithMethod:@"wall.get" andParameters:@{VK_API_OWNER_ID : ownerId, VK_API_OFFSET : @(offset), VK_API_COUNT :@(count)}];
    
    return [self requestExecute:request];
}

- (NSDictionary *)requestExecute:(VKRequest *)request {
    __block NSDictionary *dict = [[NSDictionary alloc] init];
    
    request.waitUntilDone = YES;
    
    [request executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Request executed: %@;", request.methodName);
        dict = response.json;
    } errorBlock:^(NSError *error) {
        NSLog(@"Request didn`t execute: %@ (%@);", request.methodName, error.description);
    }];
    
    return dict;
}

- (void)setOffsetPhotos:(NSNumber *)offset {
    offsetPhotos = offset.intValue;
}

- (void)saveContext {
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
        else
            NSLog(@"It`s not all!");
    }];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photosFromWall.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < photosFromWall.count) {
        PhotoData *photoData = [photosFromWall objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[photoData optimalImagesByWidth:cell.bounds.size.width]];

        [cell setupWithImage:nil];
        [cell.imageView setImageWithURL:url];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoData *data = [photosFromWall objectAtIndex:indexPath.row];
    
    PhotoShowerViewController *imageVC = [self.storyboard instantiateViewControllerWithIdentifier:IMAGEVC_ID];
    
    [imageVC setPhotoData:data];
    [self.navigationController pushViewController:imageVC animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + 2 * scrollView.frame.size.height;
    
    if (bottomEdge >= scrollView.contentSize.height) {
        NSOperation *loadPhotoData = [[NSInvocationOperation alloc] initWithTarget:self
                                                                          selector:@selector(loadPhotosWithOptions:)
                                                                            object:@{@"owner_id" : GROUP_ID, @"offset" : @(offsetPhotos), @"count" : @(30)}];
        
        [operationQueue addOperation:loadPhotoData];
    }
}

#pragma mark - VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    
}

- (void)vkSdkUserAuthorizationFailed {
    
}

#pragma mark - UIRefreshControl

- (void)refreshControlAction:(UIRefreshControl *)refreshControl {
    /*NSOperation *loadPhotoData = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(loadPhotosWithOptions:)
                                                                        object:@{@"owner_id" : GROUP_ID, @"offset" : [NSNumber numberWithInteger:0], @"count" : [NSNumber numberWithInteger:photosFromWall.count]}];
    
    [operationQueue addOperation:loadPhotoData];*/
    [refreshControl endRefreshing];
}

#pragma mark - UIBarButtonItem

- (void)actionRightBarButton {
    MapPhotosViewController *mapPhotosVC = [self.storyboard instantiateViewControllerWithIdentifier:MAPPHOTOSVC_ID];
    
    [self.navigationController pushViewController:mapPhotosVC animated:YES];
    [mapPhotosVC setMarkersCoordinatesByPhotosData:photosFromWall];
}

@end