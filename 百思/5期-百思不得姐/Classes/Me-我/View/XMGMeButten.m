//
//  XMGMeButten.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/21.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGMeButten.h"
#import "XMGMeSquare.h"
#import <UIButton+WebCache.h>

@implementation XMGMeButten
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xmg_y = self.xmg_height * 0.15;
    self.imageView.xmg_height = self.xmg_height * 0.5;
    self.imageView.xmg_width = self.imageView.xmg_height;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    self.titleLabel.xmg_x = 0;
    self.titleLabel.xmg_y = self.imageView.xmg_bottom;
    self.titleLabel.xmg_width = self.xmg_width;
    self.titleLabel.xmg_height = self.xmg_height - self.titleLabel.xmg_y;
}

- (void)setSquare:(XMGMeSquare *)square
{
    _square = square;
 
    [self setTitle:square.name forState:UIControlStateNormal];
    //if(![square.iphone  isEqual: @""]){
        [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    //}
}
@end
