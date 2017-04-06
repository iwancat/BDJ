//
//  XMGSeeBigViewController.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGSeeBigViewController.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>

#import <AssetsLibrary/AssetsLibrary.h> // iOS9开始废弃
#import <Photos/Photos.h> // iOS9开始推荐

@interface XMGSeeBigViewController () <UIScrollViewDelegate>
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation XMGSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    // scrollView.backgroundColor = [UIColor redColor];
    // scrollView.frame = self.view.bounds;
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_height = self.topic.height * imageView.xmg_width / self.topic.width;
    imageView.xmg_x = 0;
    
    if (imageView.xmg_height >= scrollView.xmg_height) { // 图片高度超过整个屏幕
        imageView.xmg_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
    } else { // 居中显示
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    self.imageView = imageView;

    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.xmg_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
