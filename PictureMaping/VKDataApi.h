//
//  VKDataApi.h
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKDataApi : NSObject

//+ (VKDataApi *)sharedVKDataApi;
+ (NSArray *)arrayPhotosFromVkJson:(NSDictionary *)json;

@end
