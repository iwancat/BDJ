//
//  XMGCommentSectionHeader.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/24.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGCommentSectionHeader.h"

@implementation XMGCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = XMGCommonBgColor;
//        UISwitch *s = [[UISwitch alloc] init];
//        s.xmg_x = 200;
//        [self.contentView addSubview:s];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = XMGCommentSectionHeaderFont;
    
    // 设置label的x值
    self.textLabel.xmg_x = XMGSmallMargin;
}
@end
