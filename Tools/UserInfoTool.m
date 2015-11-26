//
//  UserInfoTool.m
//  DDViedo
//
//  Created by iwind on 15/3/25.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "UserInfoTool.h"

@implementation UserInfoTool

///存储用户名
+(BOOL)saveUserName:(NSString *)username
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:username forKey:@"username"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}
///获取用户名
+(NSString *)getUserName
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
   return  [userDefaults objectForKey:@"username"];
}

///删除用户名
+(BOOL)deleteUserName
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"username"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储密码
+(BOOL)savePWD:(NSString *)pwd
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:pwd forKey:@"pwd"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}
///获取密码
+(NSString *)getPWD
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"pwd"];
}
///删除密码
+(BOOL)deletePWD
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"pwd"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}
///存储D_id
+(BOOL)saveD_id:(NSString *)D_id{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:D_id forKey:@"D_id"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取D_id
+(NSString *)getD_id{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"D_id"];
}
///删除D_id
+(BOOL)deleteD_id
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"D_id"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储版本号
+(BOOL)saveVersion:(NSString *)version{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:@"CurrentVersion"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}


///获取版本号
+(NSString *)getCurrentVersion{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentVersion"];
}
///删除版本号
+(BOOL)updateVersion{
    return YES;
}


@end
