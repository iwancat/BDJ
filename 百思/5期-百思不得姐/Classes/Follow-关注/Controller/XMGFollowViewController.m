//
//  XMGFollowViewController.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGFollowViewController.h"
#import "XMGRecommendFollowViewController.h"
#import "XMGLoginRegisterViewController.h"

@interface XMGFollowViewController ()
/** 文本框 */
@property (nonatomic, weak) UITextField *textField;
@end

@implementation XMGFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGCommonBgColor;
    
    // 标题(不建议使用self.title属性)
    self.navigationItem.title = @"我的关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

- (IBAction)loginRegister {
    XMGLoginRegisterViewController *loginRegister = [[XMGLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)followClick
{
    XMGLogFunc
    
    XMGRecommendFollowViewController *follow = [[XMGRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:follow animated:YES];
}

@end
