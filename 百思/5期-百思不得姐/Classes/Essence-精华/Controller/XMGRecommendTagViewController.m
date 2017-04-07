//
//  XMGRecommendTagViewController.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/8.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGRecommendTagViewController.h"
#import "XMGHTTPSessionManager.h"
#import <MJExtension.h>
#import "XMGRecommendTag.h"
#import "XMGRecommendTagCell.h"
#import <SVProgressHUD.h>

@interface XMGRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是XMGRecommendTag模型) */
@property (nonatomic, strong) NSArray<XMGRecommendTag *> *recommendTags;
/** 请求管理者 */
@property (nonatomic, weak) XMGHTTPSessionManager *manager;
@end

@implementation XMGRecommendTagViewController

/** manager属性的懒加载 */
- (XMGHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString * const XMGRecommendTagCellId = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XMGRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 加载标签数据
    [self loadNewRecommandTags];
}

/**
 *  加载标签数据
 */
- (void)loadNewRecommandTags
{
    [SVProgressHUD show];
    
    __weak typeof(self) weakSelf = self;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 字典数组 -> 模型数组
        weakSelf.recommendTags = [XMGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新
        [weakSelf.tableView reloadData];
        
        // 去除HUD
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
    }];
}

/**
 *  当控制器的view即将消失的时候调用
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 隐藏HUD
    [SVProgressHUD dismiss];
    
    // 取消请求
    // [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGRecommendTagCellId];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}
@end
