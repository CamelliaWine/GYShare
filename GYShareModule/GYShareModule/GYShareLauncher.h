//
//  TBShareLauncher.h
//  分享
//
//  Created by BlueSea on 2018/1/11.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYShareMaker.h"

@interface GYShareLauncher : NSObject

@property (strong, nonatomic) GYShareMaker *make;

@property (assign, nonatomic) GYSharePlatforms platform;

- (void)launcheWithSuccess:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure;

@end
