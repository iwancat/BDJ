//
//  UIBarButtonItem+XMGExtension.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "UIBarButtonItem+XMGExtension.h"

@implementation UIBarButtonItem (XMGExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}

//    [XMGPerson personWithName:@"4234" age:20];
//    [NSArray arrayWithContentsOfFile:<#(nonnull NSString *)#>];
//    [NSString stringWithFormat:<#(nonnull NSString *), ...#>];
//
//    [UIBarButtonItem itemWith];
//
//    [NSMutableDictionary dictionaryWithObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>];
//
//    [NSDictionary dictionaryWithObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>];
//
//    [NSDate dateWithTimeIntervalSinceNow:<#(NSTimeInterval)#>];
//
//    [NSData dataWithBytes:<#(nullable const void *)#> length:<#(NSUInteger)#>];
//
//    [UIImage imageWithContentsOfFile:<#(nonnull NSString *)#>];
@end
