//
//  GYShareMaker.m
//  GYShareModule
//
//  Created by 郑峥 on 2018/1/13.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import "GYShareMaker.h"
#import "GYShareView.h"
#import "GYShareLauncher.h"

@interface GYShareMaker ()
<GYShareViewDelegate>

@property (strong, nonatomic) NSMutableArray <NSDictionary *> *dataMuArray;

@property (copy, nonatomic) void (^success)(GYSharePlatforms platform);
@property (copy, nonatomic) void (^failure)(NSError *error);

@end

@implementation GYShareMaker

#pragma mark - LifeCircle
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - PublicMethod
- (void)installWithSuccess:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure {
    
    self.success = success;
    self.failure = failure;
    
    //自定义视图替换
    GYShareView *shareView = [GYShareView setupShareView];
    shareView.dataMuArray = self.dataMuArray;
    shareView.delegate = self;
    shareView.make = self;
    [shareView show];
}

#pragma mark - Delegate
- (void)shareView:(GYShareView *)shareView didShareToPlatform:(GYSharePlatforms)platform {
    GYShareLauncher *launcher = [GYShareLauncher new];
    launcher.make = self;
    launcher.platform = platform;
    [launcher launcheWithSuccess:self.success failure:self.failure];
}

#pragma mark - LazyLoad
- (NSMutableArray<NSDictionary *> *)dataMuArray {
    if (_dataMuArray==nil) {
        _dataMuArray = @[].mutableCopy;
        
        if (self.platforms & GYSharePlatformWXSession) {
            [_dataMuArray addObject:@{@"title":@"微信",
                                      @"icon":@"share_wechat_icon",
                                      @"platforms":@(GYSharePlatformWXSession)}];
        }
        if (self.platforms & GYSharePlatformWXTimeline) {
            [_dataMuArray addObject:@{@"title":@"朋友圈",
                                      @"icon":@"share_timeline_icon",
                                      @"platforms":@(GYSharePlatformWXTimeline)}];
        }
        if (self.platforms & GYSharePlatformWXFavorite) {
            [_dataMuArray addObject:@{@"title":@"微信收藏",
                                      @"icon":@"share_favorite_icon",
                                      @"platforms":@(GYSharePlatformWXFavorite)}];
        }
        if (self.platforms & GYSharePlatformQQSession) {
            [_dataMuArray addObject:@{@"title":@"QQ",
                                      @"icon":@"share_qq_icon",
                                      @"platforms":@(GYSharePlatformQQSession)}];
        }
        if (self.platforms & GYSharePlatformQQZone) {
            [_dataMuArray addObject:@{@"title":@"空间",
                                      @"icon":@"share_zone_icon",
                                      @"platforms":@(GYSharePlatformQQZone)}];
        }
        if (self.platforms & GYSharePlatformWeiBo) {
            [_dataMuArray addObject:@{@"title":@"微博",
                                      @"icon":@"share_weibo_icon",
                                      @"platforms":@(GYSharePlatformWeiBo)}];
        }
        if (self.platforms & GYSharePlatformLocal) {
            [_dataMuArray addObject:@{@"title":@"保存图片",
                                      @"icon":@"share_savephoto_icon",
                                      @"platforms":@(GYSharePlatformLocal)}];
        }
    }
    return _dataMuArray;
}

@end
