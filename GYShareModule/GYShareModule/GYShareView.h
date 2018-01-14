//
//  TBShareView.h
//  分享
//
//  Created by BlueSea on 2018/1/11.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYShareMaker.h"
@class GYShareView;

@protocol GYShareViewDelegate <NSObject>

@optional
- (void)shareView:(GYShareView *)shareView didShareToPlatform:(GYSharePlatforms)platform;

@end

@interface GYShareView : UIView

@property (strong, nonatomic) GYShareMaker *make;

@property (strong, nonatomic) NSMutableArray <NSDictionary *> *dataMuArray;

@property (weak, nonatomic) id <GYShareViewDelegate> delegate;

+ (instancetype)setupShareView;

- (void)show;

- (void)hidden;

@end


@interface GYShareCell : UICollectionViewCell

@property (strong, nonatomic) NSDictionary *dic;

@end
