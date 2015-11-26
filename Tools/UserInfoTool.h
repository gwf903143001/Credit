//
//  UserInfoTool.h
//  DDViedo
//
//  Created by iwind on 15/3/25.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoTool : NSObject
///存储用户名
+(BOOL)saveUserName:(NSString *)username;
///获取用户名
+(NSString *)getUserName;
///删除用户名
+(BOOL)deleteUserName;

///存储密码
+(BOOL)savePWD:(NSString *)pwd;
///获取密码
+(NSString *)getPWD;
///删除密码
+(BOOL)deletePWD;
///存储D_id
+(BOOL)saveD_id:(NSString *)D_id;
///获取D_id
+(NSString *)getD_id;
///删除D_id
+(BOOL)deleteD_id;

///存储版本号
+(BOOL)saveVersion:(NSString *)version;
///获取版本号
+(NSString *)getCurrentVersion;
///删除版本号
+(BOOL)updateVersion;


@end
