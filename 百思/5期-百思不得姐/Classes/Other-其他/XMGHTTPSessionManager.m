//
//  XMGHTTPSessionManager.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/19.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGHTTPSessionManager.h"

@implementation XMGHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
//        self.securityPolicy.validatesDomainName = NO;
//        self.responseSerializer = nil;
//        self.requestSerializer = nil;
    }
    return self;
}

@end
