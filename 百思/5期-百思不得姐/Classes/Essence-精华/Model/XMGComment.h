//
//  XMGComment.h
//  5期-百思不得姐
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUser;

@interface XMGComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) XMGUser *user;
@end
