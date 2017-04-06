//
//  XMGTopicViewController.h
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopic.h"

@interface XMGTopicViewController : UITableViewController
/** 帖子的类型 */
// @property (nonatomic, assign) XMGTopicType type;

- (XMGTopicType)type;

// 这个属性会生成一个type的get方法 和 _type成员变量
// @property (nonatomic, assign, readonly) XMGTopicType type;
@end

/**
 父类中的某个内容, 只允许由子类来修改\提供, 不能由外界来修改\提供
*/