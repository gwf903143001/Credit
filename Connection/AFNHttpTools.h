//
//  AFNHttpTools.h

//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface AFNHttpTools : NSObject

typedef void (^RequestSuccessed) (NSDictionary *dict);

typedef void (^RequestFailed) (NSError *err);

//把字典转化为json字符串用来打印
+(NSString *)jsonStringWithDict:(NSDictionary *)dict;


///post请求方法1
+(void)requestWithUrl:(NSString *)url andPostDict:(NSDictionary *)postDict successed:(RequestSuccessed)successed failed:(RequestFailed)failed;
///post请求方法2
+(void)requestWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSString *)firstobj,...NS_REQUIRES_NIL_TERMINATION;

//上传图片的
/**
  上传图片
  para url: 相对地址
  para dict:参数的字典
  para image:图片
 */
+(void)imageRequestWithUrl:(NSString *)url postDict:(NSDictionary *)dict image:(id)postimage successed:(RequestSuccessed)successed failed:(RequestFailed)failed;
@end
