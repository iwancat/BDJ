//
//  XMGTopicCell.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGTopicCell.h"
#import <UIImageView+WebCache.h>
#import "XMGComment.h"
#import "XMGUser.h"
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"

@interface XMGTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
@end

@implementation XMGTopicCell
#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}




- (IBAction)more {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"我的标题" message:@"消息内容" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alert show];
    
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"我的标题" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"其他按钮", nil];
    //    [sheet showInView:self];
    
    // UIAlertControllerStyleAlert  == UIAlertView
    // UIAlertControllerStyleActionSheet == UIActionSheet
    // UIAlertController == UIAlertView + UIActionSheet
    
    //    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"我的标题" message:@"消息内容" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    //    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.textColor = [UIColor redColor];
    //    }];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 初始化
- (void)awakeFromNib
{
    //self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at; // 调用get方法[topic created_at];
    self.text_label.text = topic.text;
    
    //    if (topic.ding >= 10000) {
    //        [self.dingButton setTitle:[NSString stringWithFormat:@"%.1f万", topic.ding / 10000.0] forState:UIControlStateNormal];
    //    } else if (topic.ding > 0) {
    //        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd", topic.ding] forState:UIControlStateNormal];
    //    } else {
    //        [self.dingButton setTitle:@"顶" forState:UIControlStateNormal];
    //    }
    
    //    topic.ding = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.cai = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.repost = arc4random_uniform(8000) + arc4random_uniform(5000);
    //    topic.comment = 0;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    /*
     数量 >= 10000
     比如53454 -> 5.3万
     
     数量 < 10000
     比如5435 -> 5435
     比如546 -> 546
     
     数量 == 0
     比如0 -> 评论
     
     */
    
    // 没有最热评论
    // topic.top_cmt = @[];
    
    // 有最热评论
    // topic.top_cmt = @[@{}];
    
    // 最热评论 不能用if (topic.top_cmt)
    // if (topic.top_cmt.count) { // 有最热评论
    
//    NSDictionary *comment = topic.top_cmt.firstObject;
//    if (comment) { // 有最热评论
//        self.topCmtView.hidden = NO;
//        
//        NSString *username = comment[@"user"][@"username"]; // 用户名
//        NSString *content = comment[@"content"]; // 评论内容
//        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
//    } else { // 没有最热评论
//        self.topCmtView.hidden = YES;
//    }
    // 最热评论
    if (topic.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.user.username; // 用户名
        NSString *content = topic.top_cmt.content; // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
   /* // 中间内容
#pragma mark - 根据XMGTopic模型数据的情况来决定中间添加什么控件(内容)
    if (topic.type == XMGTopicTypeVideo) { // 视频
        
    } else if (topic.type == XMGTopicTypeVoice) { // 音频
        
    } else if (topic.type == XMGTopicTypeWord) { // 段子
        
    } else if (topic.type == XMGTopicTypePicture) { // 图片
        
    }*/
    // 中间内容
    if (topic.type == XMGTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == XMGTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == XMGTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }


}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XMGMargin;
    frame.origin.y += XMGMargin;
    //    frame.origin.x += XMGMargin;
    //    frame.size.width -= 2 * XMGMargin;
    
    [super setFrame:frame];
}

@end
