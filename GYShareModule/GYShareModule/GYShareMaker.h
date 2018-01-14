//
//  GYShareMaker.h
//  GYShareModule
//
//  Created by 郑峥 on 2018/1/13.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, GYSharePlatforms) {
    GYSharePlatformLocal       = 1,
    GYSharePlatformWXSession   = 1 << 1,
    GYSharePlatformWXTimeline  = 1 << 2,
    GYSharePlatformWXFavorite  = 1 << 3,
    GYSharePlatformQQSession   = 1 << 4,
    GYSharePlatformQQZone      = 1 << 5,
    GYSharePlatformWeiBo       = 1 << 6,
};

typedef NS_ENUM(NSUInteger, GYMediaType){
    GYLink = 1,
    GYImage = 2
};

@interface GYShareMaker : NSObject

@property (assign, nonatomic) GYMediaType mediaType;

@property (assign, nonatomic) GYSharePlatforms platforms;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *desc;

@property (copy, nonatomic) NSString *url;

@property (strong, nonatomic) UIImage *thumbImage;

@property (strong, nonatomic) UIImage *image;

- (void)installWithSuccess:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure;

@end
