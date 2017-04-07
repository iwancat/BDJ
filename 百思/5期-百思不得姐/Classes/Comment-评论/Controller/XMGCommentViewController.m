//
//  XMGCommentViewController.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/23.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGCommentViewController.h"

@interface XMGCommentViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@end

@implementation XMGCommentViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
}

- (void)setupBase
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    if (弹出) {
//        self.bottomMargin.constant = 键盘高度;
//    } else {
//        self.bottomMargin.constant = 0;
//    }
    
    // 修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - <UITableViewDelegate>
/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end