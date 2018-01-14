//
//  GYShareScheduler.h
//  GYShareModule
//
//  Created by 郑峥 on 2018/1/13.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYShareMaker.h"

@interface GYShareScheduler : NSObject

+ (void)share:(void (^)(GYShareMaker *make))block success:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure;

@end
