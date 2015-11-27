//
//  PicturesViewController.h
//  PictureMaping
//
//  Created by Alexey on 11/15/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk/VKSdk.h"
#import <CoreData/CoreData.h>

@interface PicturesViewController : UICollectionViewController <VKSdkDelegate>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
