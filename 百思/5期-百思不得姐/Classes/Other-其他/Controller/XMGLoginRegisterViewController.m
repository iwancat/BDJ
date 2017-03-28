//
//  XMGLoginRegisterViewController.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/8.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterTextField.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@end

@implementation XMGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  关闭当前界面
 */
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  显示登录\注册界面
 */
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant) { // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        button.selected = NO;
    } else { // 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = - self.view.xmg_width;
        button.selected = YES;
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
