//
//  XMGQuickLoginButton.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/8.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGQuickLoginButton.h"

@implementation XMGQuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xmg_y = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    self.titleLabel.xmg_x = 0;
    self.titleLabel.xmg_y = self.imageView.xmg_bottom;
    self.titleLabel.xmg_height = self.xmg_height - self.titleLabel.xmg_y;
    self.titleLabel.xmg_width = self.xmg_width;
}

@end
