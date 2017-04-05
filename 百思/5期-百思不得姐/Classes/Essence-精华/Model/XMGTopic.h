//
//  XMGTopic.h
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef enum {
//    /** 图片 */
//    XMGTopicTypePicture = 10,
//    /** 段子 */
//    XMGTopicTypeWord = 29,
//    /** 声音 */
//    XMGTopicTypeVoice = 31,
//    /** 视频 */
//    XMGTopicTypeVideo = 41,
//} XMGTopicType;

typedef NS_ENUM(NSUInteger, XMGTopicType) {
    /** 图片 */
    XMGTopicTypePicture = 10,
    /** 段子 */
    XMGTopicTypeWord = 29,
    /** 声音 */
    XMGTopicTypeVoice = 31,
    /** 视频 */
    XMGTopicTypeVideo = 41
};

@class XMGComment;

@interface XMGTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 最热评论 */
@property (nonatomic, strong) XMGComment *top_cmt;

/** 帖子类型 */
@property (nonatomic, assign) XMGTopicType type;

@end
