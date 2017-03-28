//
//  XMGMeFooterView.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/19.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import <SafariServices/SafariServices.h>

#import "XMGMeSquare.h"
#import "XMGMeButten.h"
#import "XMGWebController.h"

@implementation XMGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 参数
        [self loadData];

    }
//    self.xmg_height = 90;
//    self.backgroundColor = [UIColor redColor ];
    return self;
}
/**
 *  根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares
{
    
    // 方块个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4; // 一行的最大列数
    CGFloat buttonW = self.xmg_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        // i位置对应的模型数据
        XMGMeSquare *square = squares[i];
        //NSLog(@"------%@++++++%@****%lu",square.name,square.icon,(unsigned long)count);
        // 创建按钮
        XMGMeButten *button = [XMGMeButten buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.xmg_x = (i % maxColsCount) * buttonW;
        button.xmg_y = (i / maxColsCount) * buttonH;
        button.xmg_width = buttonW;
        button.xmg_height = buttonH;
        
        // 设置数据
        
        button.square = square;
        
        //        button.backgroundColor = XMGRandomColor;
//        [button setTitle:square.name forState:UIControlStateNormal];
//        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        //        [button.imageView sd_setImageWithURL:[NSURL URLWithString:square.icon] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        //        [button setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
        //        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //            [button setImage:image forState:UIControlStateNormal];
        //        }];
    }
    // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.xmg_height = self.subviews.lastObject.xmg_bottom;
    
//    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData]; // 重新刷新数据(会重新计算contentSize)
    //tableView.contentSize = CGSizeMake(0, self.xmg_bottom); // 不靠谱
}

-(void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseObject) {
       // XMGLog(@"请求成功 - %@", responseObject);
        //NSLog(@"*******************************************************");
        //[responseObject writeToFile:@"/Users/myMac/Desktop/data.plist" atomically:YES];
        // 字典数组 -> 模型数组
        //字典转模型   MJ
        NSArray *squares = [XMGMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
       
        //字典转模型
//      NSMutableArray *marray = [[NSMutableArray alloc] init];
//        for (NSInteger i = 0; i<dica.count; i++) {
//            XMGMeSquare * xms = [[XMGMeSquare alloc ]init];
//            xms.name = [dica[i] valueForKey:@"name" ];
//            xms.icon = [dica[i] valueForKey:@"icon" ];
//            xms.url = [dica[i] valueForKey:@"url" ];
//            [marray addObject:xms];
//        }
//        XMGMeSquare * xmstitle =marray[3];
//        NSLog(@"----------------%@",xmstitle.name);
        // 根据模型数据创建对应的控件
         [self createSquares:squares];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"请求失败 - %@", error);
    }];
}


- (void)buttonClick:(XMGMeButten *)button
{
    XMGMeSquare *square = button.square;
    NSString *url = square.url;
    //XMGLog(@"%@----%@",square.name,square.iphone);
    
    if ([square.url hasPrefix:@"http"]) { // 利用webView加载url即可
        // 使用SFSafariViewController显示网页
//                SFSafariViewController *webView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
//                UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
//                [tabBarVc presentViewController:webView animated:YES completion:nil];
        
        
        // 获得"我"模块对应的导航控制器   拿第一个控制器
        //        UITabBarController *tabBarVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        //        UINavigationController *nav = tabBarVc.childViewControllers.firstObject;
        // 获得"我"模块对应的导航控制器   拿选中的控制器
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVc.selectedViewController;
        
        // 显示XMGWebViewController
        XMGWebController *webView = [[XMGWebController alloc] init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
    } else if ([square.url hasPrefix:@"mod"]) { // 另行处理
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            XMGLog(@"跳转到[审帖]界面");
        } else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]) {
            XMGLog(@"跳转到[每日排行]界面");
        } else {
            XMGLog(@"跳转到其他界面");
        }
    } else {
        XMGLog(@"不是http或者mod协议的");
    }
}
@end
