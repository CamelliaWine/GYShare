//
//  GYShareScheduler.m
//  GYShareModule
//
//  Created by 郑峥 on 2018/1/13.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import "GYShareScheduler.h"

@implementation GYShareScheduler

#pragma mark - LifeCircle
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma makr - PublicMethod
+ (void)share:(void (^)(GYShareMaker *make))block success:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure {
    GYShareMaker *make = [GYShareMaker new];
    block(make);
    [make installWithSuccess:success failure:failure];
}

@end
