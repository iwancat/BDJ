//
//  XMGRefreshFooter.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGRefreshFooter.h"

@implementation XMGRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
    //    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    self.automaticallyRefresh = NO;
}

@end
