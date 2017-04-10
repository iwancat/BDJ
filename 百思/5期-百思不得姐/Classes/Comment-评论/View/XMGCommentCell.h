//
//  XMGCommentCell.h
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGComment;

@interface XMGCommentCell : UITableViewCell
/** 评论模型数据 */
@property (nonatomic, strong) XMGComment *comment;
@end
