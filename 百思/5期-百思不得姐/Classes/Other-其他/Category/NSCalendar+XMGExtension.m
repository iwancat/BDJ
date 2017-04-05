//
//  NSCalendar+XMGExtension.m
//  5期-百思不得姐
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "NSCalendar+XMGExtension.h"

@implementation NSCalendar (XMGExtension)
+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
    
}
@end
