//
//  UIImage+XMGExtension.h
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/23.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMGExtension)
/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;
@end
