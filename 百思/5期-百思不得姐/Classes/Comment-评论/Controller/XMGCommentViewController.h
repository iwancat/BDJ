//
//  XMGCommentViewController.h
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/23.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGCommentViewController : UIViewController
/** 帖子模型数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
