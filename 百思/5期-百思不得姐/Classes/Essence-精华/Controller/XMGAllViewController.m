//
//  XMGAllViewController.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/30.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGAllViewController.h"
#import <AFNetworking.h>
#import "XMGTopic.h"
#import "MJExtension.h"
#import <UIImageView+WebCache.h>
#import "XMGRefreshHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGTopic.h"
#import "XMGTopicCell.h"

@interface XMGAllViewController ()
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<XMGTopic *> *topics;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation XMGAllViewController
static NSString * const XMGTopicCellId = @"topic";
#pragma mark -懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
    

}

-(void)setupTable
{
    //self.view.backgroundColor = XMGRandomColor;
    //XMGLogFunc
    
    self.tableView.backgroundColor = XMGCommonBgColor;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    //self.tableView.rowHeight = 250;
}

-(void)setupRefresh
{
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据加载

/*
 self.topics = @[20, 19, 18];
 
 
 下拉刷新操作: @[22, 21, 20]
 上拉刷新操作: @[17, 16, 15]
 
 下拉 -> 上拉
 self.topics = @[22, 21, 20, 17, 16, 15];
 
 上拉 -> 下拉
 self.topics = @[22, 21, 20];
 */


- (void)loadNewTopics
{
    
    // 取消所有请求
    //    for (NSURLSessionTask *task in self.manager.tasks) {
    //        [task cancel];
    //    }
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 关闭NSURLSession + 取消所有请求
    // [self.manager invalidateSessionCancelingTasks:YES];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //        [responseObject writeToFile:@"/Users/xiaomage/Desktop/new_topics.plist" atomically:YES];
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];

        // 字典数组 -> 模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) {
            // 取消了任务
        } else {
            // 是其他错误
        }
        
        XMGLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];

}

// 一个请求任务被取消了(cancel), 会自动调用AFN请求的failure这个block

#pragma mark -加载更多数据
-(void) loadMoreTopics{
    
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @"1";
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<XMGTopic *> *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = XMGRandomColor;
    }
    
    // 4.显示数据
    XMGTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];*/

    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    cell.topic = self.topics[indexPath.row];

    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}
//自己做刷新的思路
//- (void)setupRefresh
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.xmg_height = 50;
//    headerView.xmg_width = self.tableView.xmg_width;
//    headerView.backgroundColor = XMGRandomColor;
//    headerView.xmg_y = - 50;
//    [self.tableView addSubview:headerView];
//
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"下拉可以刷新";
//    [label sizeToFit];
//    label.center = CGPointMake(headerView.xmg_width * 0.5, headerView.xmg_height * 0.5);
//    [headerView addSubview:label];
//    self.label = label;
//}
//#pragma mark - 代理方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentInset.top == 149) return;
//
//    if (scrollView.contentOffset.y <= - 149.0) {
//        self.label.text = @"松开立即刷新";
//    } else {
//        self.label.text = @"下拉可以刷新";
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView.contentOffset.y <= - 149.0) { // 进入下拉刷新状态
//        self.label.text = @"正在刷新";
//        [UIView animateWithDuration:0.5 animations:^{
//            UIEdgeInsets inset = scrollView.contentInset;
//            inset.top = 149;
//            scrollView.contentInset = inset;
//        }];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:0.5 animations:^{
//                UIEdgeInsets inset = scrollView.contentInset;
//                inset.top = 99;
//                scrollView.contentInset = inset;
//            }];
//        });
//    }
//}
@end
