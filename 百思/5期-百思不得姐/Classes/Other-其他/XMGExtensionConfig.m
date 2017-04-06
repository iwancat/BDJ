//
//  XMGExtensionConfig.m
//  5期-百思不得姐
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import "XMGExtensionConfig.h"
#import <MJExtension.h>
#import "XMGTopic.h"
#import "XMGComment.h"

@implementation XMGExtensionConfig

+ (void)load
{
    [XMGTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [XMGComment class]};
    }];
    
    [XMGTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
}
@end
