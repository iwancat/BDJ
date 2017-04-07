//
//  XMGRecommendTag.h
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/8.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendTag : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
