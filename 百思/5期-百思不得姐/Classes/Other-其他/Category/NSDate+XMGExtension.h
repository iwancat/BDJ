//
//  NSDate+XMGExtension.h
//  5期-百思不得姐
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)
/**  */
// @property (nonatomic, copy) NSString *name;
//- (NSString *)name;
//- (void)setName:(NSString *)name;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
