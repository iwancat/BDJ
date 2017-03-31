//
//  XMGTitleButton.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/29.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置按钮颜色
        // self.selected = NO;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        // self.selected = YES;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}


@end
