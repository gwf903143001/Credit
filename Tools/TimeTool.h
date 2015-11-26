//
//  TimeTool.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject
/**
 *  时间戳转换字符串
 *
 *  @param time 时间戳
 *
 *  @return 字符串
 */
+(NSString *)dateToString:(NSString *)time;
//计算多少天，多少小时，多少分钟，前
+(NSString *)getUTCFormateDate:(NSString *)newsDate;

+(NSString *)timeStrTransverterSince1970Time:(NSString *)timeStr;

+(NSDate *)timeStrTransverterDate:(NSString *)timeStr;

+(NSDateComponents *)timeConmponet:(NSString *)time;
/**活动模块计算宝宝年龄**/
+(NSMutableString *)getBabyAgeWithBirthday:(NSString *)brithday publicTime:(NSString *)publicTime;
/**话题关闭**/
+(BOOL)limitTime:(NSString *)limitTime;

/**发布活动 选择有效时间 15天， 计算15天后的日期**/

+(NSString *)getmyLimitTime:(NSString *)string;
/**获取当前时间戳**/
+(NSString *)since1970Time;
/**传入NSDate返回时间**/
+(NSString *)getTimeWithDate:(NSDate *)date;
/**获取当前时间字符串**/
+(NSString *)nowTimeStr;

/**传入NSDate返回时间**/

+(NSString *)getTimeWithDate:(NSDate *)date andFormatterString:(NSString *)formatterString;
@end
