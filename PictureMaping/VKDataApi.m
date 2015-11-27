//
//  VKDataApi.m
//  PictureMaping
//
//  Created by Alexey on 11/16/15.
//  Copyright © 2015 ShagaleevInc. All rights reserved.
//

#import "VKDataApi.h"
#import "PhotoData.h"

@implementation VKDataApi

/*static VKDataApi *sharedVKDataApi = nil;

+ (VKDataApi *)sharedVKDataApi {
    if ((!sharedVKDataApi) || (sharedVKDataApi == nil)) {
        sharedVKDataApi = [VKDataApi new];
    }
    
    return sharedVKDataApi;
}*/

+ (NSArray *)arrayPhotosFromVkJson:(NSDictionary *)json {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSArray *items = [json objectForKey:@"items"];
        
    for (NSDictionary *item in items) {
        NSArray *attachments = [item objectForKey:@"attachments"];
        
        if (attachments) {
            for (NSDictionary *attach in attachments) {
                NSDictionary *attachPhoto = [attach objectForKey:@"photo"];
                    
                if (attachPhoto) {
                    [array addObject:[[PhotoData alloc] initWithDict:attachPhoto]];
                }
            }
        }
    }
    
    return array;
}

@end
