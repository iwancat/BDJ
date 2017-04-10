//
//  XMGCommentViewController.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/23.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGCommentViewController.h"
#import "XMGHTTPSessionManager.h"
#import "XMGRefreshHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGTopic.h"
#import "XMGComment.h"
#import <MJExtension.h>
#import "XMGCommentSectionHeader.h"
#import "XMGCommentCell.h"
#import "XMGTopicCell.h"

@interface XMGCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

/** 任务管理者 */
@property (nonatomic, strong) XMGHTTPSessionManager *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<XMGComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<XMGComment *> *latestComments;

// 对象属性名不能以new开头
// @property (nonatomic, strong) NSMutableArray<XMGComment *> *newComments;

/** 最热评论 */
@property (nonatomic, strong) XMGComment *savedTopCmt;
@end

@implementation XMGCommentViewController

static NSString * const XMGCommentCellId = @"comment";
static NSString * const XMGSectionHeaderlId = @"header";

#pragma mark - 懒加载
- (XMGHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
   // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGTopicCellId];
   // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGCommentCellId];
    [self setupHeader];
}

- (void)setupHeader
{
    // 处理模型数据
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 添加cell到header
    XMGTopicCell *cell = [XMGTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [header addSubview:cell];
    
    // 设置header的高度
    header.xmg_height = cell.xmg_height + XMGMargin * 2;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:XMGCommentCellId];
    [self.tableView registerClass:[XMGCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:XMGSectionHeaderlId];
    
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
//    headerView.xmg_height = 200;
//    self.tableView.tableHeaderView = headerView;
    
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = XMGCommentSectionHeaderFont.lineHeight + 2;
    
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)setupBase
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
// 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}
#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // @"1";
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        weakSelf.latestComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        // 字典数组 -> 模型数组
        NSArray *moreComments = [XMGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) { // 全部加载完毕
            // 提示用户:没有更多数据
            // [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.tableView.mj_footer.hidden = YES;
        } else { // 还没有加载完全
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

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
#pragma mark - 数据源方法
/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    if (section == 1) return 4;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
       // cell.textLabel.text = @"最顶部的帖子数据";
       // return cell;
    } else {
      //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCommentCellId];
      //  cell.textLabel.text = [NSString stringWithFormat:@"评论数据 - %zd-%zd", indexPath.section, indexPath.row];
      //  return cell;
    }
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (self.latestComments.count && self.hotestComments.count) return 2;
    //    if (self.latestComments.count && self.hotestComments.count == 0) return 1;
    //
    //    return 0;
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.latestComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    // 第0组
    //    if (section == 0) {
    //        if (self.hotestComments.count) {
    //            return self.hotestComments.count;
    //        } else {
    //            return self.latestComments.count;
    //        }
    //    }
    //
    //    // 其他组 - section == 1
    //    return self.latestComments.count;
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 其他情况
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCommentCellId];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;
}



/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    if (section == 1) return @"最热评论";
    return @"最新评论";
}*/
#pragma mark - <UITableViewDelegate>
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XMGCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XMGSectionHeaderlId];
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else { // 其他情况
        header.textLabel.text = @"最新评论";
    }
    
    return header;
}

#pragma mark - <UITableViewDelegate>
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) return 200;
//    return 44;
//}
/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
