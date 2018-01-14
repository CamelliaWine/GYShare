//
//  TBShareView.m
//  分享
//
//  Created by BlueSea on 2018/1/11.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import "GYShareView.h"

#define GYRatioWidth(x) [UIScreen mainScreen].bounds.size.width/375*(x)
#define GYRatioHeight(x) [UIScreen mainScreen].bounds.size.height/568*(x)

static const CGFloat kBeginAlpha = 0.00f;
static const CGFloat kEndAlpha = 0.30f;
static NSString * const ID_GYShareCell = @"ID_GYShareCell";

@interface GYShareView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (strong, nonatomic) UIView *shareBgView;
@property (strong, nonatomic) UIButton *cancleButton;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation GYShareView

#pragma mark - LifeCircle
+ (instancetype)setupShareView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:kBeginAlpha];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - PublicMethod
- (void)show {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [self addSubview:self.shareBgView];
    [self.shareBgView addSubview:self.collectionView];
    [self.shareBgView addSubview:self.cancleButton];

    [UIView animateWithDuration:0.20f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:kEndAlpha];
        self.shareBgView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-164, CGRectGetWidth(self.bounds), 164);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidden {
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:kBeginAlpha];
        self.shareBgView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 164);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Events
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    if (CGRectContainsPoint(self.shareBgView.frame, currentPoint)==NO) {
        [self hidden];
    }
}

- (void)cancleButtonClicked:(UIButton *)sender {
    [self hidden];
}

#pragma mark - Protocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataMuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GYShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID_GYShareCell forIndexPath:indexPath];
    cell.dic = self.dataMuArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(shareView:didShareToPlatform:)]) {
        GYSharePlatforms platform = (GYSharePlatforms)([self.dataMuArray[indexPath.item][@"platforms"] integerValue]);
        [self.delegate shareView:self didShareToPlatform:platform];
    }
}

#pragma mark - LazyLoad
- (UIView *)shareBgView {
    if (_shareBgView==nil) {
        _shareBgView = [[UIView alloc] init];
        _shareBgView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 164);
        _shareBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shareBgView;
}

- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.shareBgView.bounds), 120) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        _collectionView.bounces = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[GYShareCell class] forCellWithReuseIdentifier:ID_GYShareCell];
    }
    return _collectionView;
}

- (UIButton *)cancleButton {
    if (_cancleButton==nil) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.backgroundColor = [UIColor whiteColor];
        _cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), CGRectGetWidth(self.shareBgView.bounds), CGRectGetHeight(self.shareBgView.bounds)-120);
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        [_cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout==nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(GYRatioWidth(125), 120);
        
        CGFloat space = 0.0;
        if (self.dataMuArray.count<3) {
             space = (CGRectGetWidth(self.bounds)-self.dataMuArray.count*GYRatioWidth(125))/(self.dataMuArray.count+1);
        }
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = space;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (void)setDataMuArray:(NSMutableArray<NSDictionary *> *)dataMuArray {
    _dataMuArray = dataMuArray;
    
    [self.collectionView reloadData];
}

@end


@interface GYShareCell ()

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation GYShareCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    self.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
    self.titleLabel.text = dic[@"title"];
}

- (UIImageView *)iconImageView {
    if (_iconImageView==nil) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-55)/2, 20, 55, 55)];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame)+10, CGRectGetWidth(self.bounds), 15)];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
