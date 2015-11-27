//
//  LocalPhotosCollectionViewController.m
//  PictureMaping
//
//  Created by Alexey on 11/27/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "LocalPhotosCollectionViewController.h"
#import "UICollectionViewCell+UIImage.h"
#import "UIImageView+CoreData.h"

@interface LocalPhotosCollectionViewController ()

@end

@implementation LocalPhotosCollectionViewController

static NSString * const reuseIdentifier = @"cell_id0";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _photos = [[Photo MR_findAll] copy];
    
    NSLog(@"Load %d photos", _photos.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setupWithImage:nil];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [_photos objectAtIndex:indexPath.row];

    [cell.imageView setImageWithURL:[NSURL URLWithString:photo.minimizedPhoto]];
    
    NSLog(@"SetImage");
}

@end