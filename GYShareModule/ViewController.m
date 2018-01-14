//
//  ViewController.m
//  GYShareModule
//
//  Created by 郑峥 on 2018/1/13.
//  Copyright © 2018年 山茶花酿酒. All rights reserved.
//

#import "ViewController.h"
#import "GYShareScheduler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.28 green:0.69 blue:0.96 alpha:1.00];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [GYShareScheduler share:^(GYShareMaker *make) {
    
        make.mediaType = GYLink;
        make.platforms = GYSharePlatformWXSession|GYSharePlatformWXTimeline|GYSharePlatformWXFavorite|GYSharePlatformLocal|GYSharePlatformQQZone|GYSharePlatformQQSession|GYSharePlatformWeiBo;
        make.title = @"链接分享";
        make.desc = @"分享副标题";
        make.url = @"https://www.baidu.com";
    
    } success:^(GYSharePlatforms platform) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
