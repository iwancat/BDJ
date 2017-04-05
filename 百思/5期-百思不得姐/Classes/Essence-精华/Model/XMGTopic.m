//
//  XMGTopic.m
//  5期-百思不得姐
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
/**
 *  在第一次使用XMGTopic类时调用1次
 */
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

//    nowDate.name;
//    [nowDate name];
//
//    nowDate.name = nil;
//    [nowDate setName:nil];

- (NSString *)created_at
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        } else { // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _created_at;
    }
    
    //    if ([createdAtDate isThisYear]) {
    //
    //    }
}

/**
 // _created_at == @"2015-11-20 09:10:05"
 // _created_at -> @"刚刚" \ @"10分钟前" \ @"5小时前" \ @"昨天 09:10:05" \ @"11-20 09:10:05" \ @"2015-11-20 09:10:05"
 
 今年
 今天
 时间间隔 >= 1小时 - @"5小时前"
 1小时 > 时间间隔 >= 1分钟 - @"10分钟前"
 1分钟 > 分钟 - @"刚刚"
 昨天 - @"昨天 09:10:05"
 其他 - @"11-20 09:10:05"
 
 
 非今年 - @"2015-11-20 09:10:05"
 
 */
@end
