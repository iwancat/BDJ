//
//  XMGRefreshHeader.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGRefreshHeader.h"
#import <UIImageView+WebCache.h>
@interface XMGRefreshHeader()
/** logo */
@property (nonatomic, weak) UIImageView *logo;
@end
@implementation XMGRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
   
    
    UIImageView *logo = [[UIImageView alloc] init];
    [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/img/bd_logo1.png"]]];
    [self addSubview:logo];
    self.logo = logo;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.xmg_width = self.xmg_width;
    self.logo.xmg_height = 100;
    self.logo.xmg_x = 0;
    self.logo.xmg_y = - 100;
}


@end
