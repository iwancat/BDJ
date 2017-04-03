//
//  XMGTopicCell.h
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopic.h"

@interface XMGTopicCell : UITableViewCell
/** 帖子模型数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
