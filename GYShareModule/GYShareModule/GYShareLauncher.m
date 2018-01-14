//
//  TBShareLauncher.m
//  分享
//
//  Created by BlueSea on 2018/1/11.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import "GYShareLauncher.h"
#import <WechatOpenSDK/WXApi.h>
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WechatAuthSDK.h>

@interface GYShareLauncher ()

@property (copy, nonatomic) void (^success)(GYSharePlatforms platform);
@property (copy, nonatomic) void (^failure)(NSError *error);

@end

@implementation GYShareLauncher

#pragma mark - LifeCircle
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - PublicMethod
- (void)launcheWithSuccess:(void (^)(GYSharePlatforms platform))success failure:(void (^)(NSError *error))failure {
    
    self.success = success;
    self.failure = failure;
    
    switch (self.platform) {
        case GYSharePlatformLocal:
            break;
        case GYSharePlatformWXSession: {
            [self shareWXPlatform:WXSceneSession];
        } break;
        case GYSharePlatformWXTimeline: {
            [self shareWXPlatform:WXSceneTimeline];
        } break;
        case GYSharePlatformWXFavorite:{
            [self shareWXPlatform:WXSceneFavorite];
        } break;
        default:
            break;
    }
}

#pragma mark - PrivateMethod
#pragma mark - 微信
/** 微信分享权限 */
- (BOOL)checkWXAuthority {
    if (![WXApi isWXAppInstalled]) {
        if (self.failure) {
            self.failure([NSError errorWithDomain:@"GYErrorDomain" code:00001 userInfo:@{@"GYErrorInfo":@"微信未被安装"}]);
        }
        return NO;
    }
    if (![WXApi isWXAppSupportApi]) {
        if (self.failure) {
            self.failure([NSError errorWithDomain:@"GYErrorDomain" code:00002 userInfo:@{@"GYErrorInfo":@"当前微信的版本不支持OpenApi"}]);
        }
        return NO;
    }
    return YES;
}

/** 微信分享 */
- (void)shareWXPlatform:(int)scene {
    
    if (![self checkWXAuthority]) {
        return;
    }
    
    if (self.make.mediaType == GYLink) {
        
        WXMediaMessage *wxMessage = [WXMediaMessage message];
        wxMessage.title = self.make.title;
        wxMessage.description = self.make.desc;
        [wxMessage setThumbImage:self.make.thumbImage];
        
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = self.make.url;
        wxMessage.mediaObject = webpageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = wxMessage;
        req.scene = scene;
        
        BOOL result = [WXApi sendReq:req];
        if (result==YES && self.success) {
            self.success(self.platform);
        } else if (result==NO && self.failure) {
            self.failure([NSError errorWithDomain:@"GYErrorDomain" code:0001 userInfo:@{@"GYErrorInfo":@"微信分享链接失败"}]);
        }
        
    } else if (self.make.mediaType == GYImage) {
        
        WXMediaMessage *wxMessage = [WXMediaMessage message];
        [wxMessage setThumbImage:self.make.thumbImage];
        
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = UIImageJPEGRepresentation(self.make.image, 1.0);
        wxMessage.mediaObject = imageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = wxMessage;
        req.scene = scene;
        
        BOOL result = [WXApi sendReq:req];
        if (result==YES && self.success) {
            self.success(self.platform);
        } else if (result==NO && self.failure) {
            self.failure([NSError errorWithDomain:@"GYErrorDomain" code:0001 userInfo:@{@"GYErrorInfo":@"微信分享图片失败"}]);
        }
    }
}









@end
