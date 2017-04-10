//
//  XMGUser.h
//  5期-百思不得姐
//
//  Created by Mac on 17/4/5.
//  Copyright © 2017年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;
@end
