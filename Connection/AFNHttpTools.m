//
//  AFNHttpTools.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "AFNHttpTools.h"
#import "AFNetworking.h"
#import "TimeTool.h"
#import "CONSTANT.h"
@implementation AFNHttpTools

#pragma mark - 把字典转化为json字符串用来打印
+(NSString *)jsonStringWithDict:(NSDictionary *)dict
{
    NSError * err;
    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return json;
}



+(void)requestWithUrl:(NSString *)url andPostDict:(NSDictionary *)postDict successed:(RequestSuccessed)successed failed:(RequestFailed)failed
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * str = [url substringFromIndex:url.length - 1];
    if([str isEqualToString:@"/"])
    {
        url = [url substringToIndex:url.length - 1];
    }
    
    NSString * newUrl = [URL_BASE stringByAppendingString:url];
    [manager POST:newUrl parameters:postDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果的Json串为:%@", [self jsonStringWithDict:responseObject]);
        successed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误原因是：%@", error);
        failed(error);
    }];
}

+(void)requestWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSObject *)firstobj,...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray * keys = [[NSMutableArray alloc]init];
    
    NSMutableArray * values = [[NSMutableArray alloc]init];
    
    va_list arg_ptr;
    
    va_start(arg_ptr, firstobj);
    
    if(nil == firstobj)
    {
        return;
    }
    [keys addObject:firstobj];
    
    NSObject * temp = nil;
    
    NSInteger i  = 1;
    
    while((temp = va_arg(arg_ptr, NSObject *)))
    {
        if (i % 2 == 1)
        {
            [values addObject:temp];
        }else{
            [keys addObject:temp];
        }
        i++;
    }
    if(i % 2 == 1)
    {
        NSLog(@"变长参数的个数是奇数");
        NSLog(@"最后一个参数是%ld", (long)i);
        
        return;
    }
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSLog(@"请求字典是%@", postDict);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * str = [url substringFromIndex:url.length - 1];
    if([str isEqualToString:@"/"])
    {
        url = [url substringToIndex:url.length - 1];
    }
    
    NSString * newUrl = [URL_BASE stringByAppendingString:url];

    NSLog(@"请求地址是%@", newUrl);
    
    [manager POST:newUrl parameters:postDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果的Json串为:%@", [self jsonStringWithDict:responseObject]);
        successed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误原因是：%@", error);
        failed(error);
    }];
}
//上传图片的
+(void)imageRequestWithUrl:(NSString *)url postDict:(NSDictionary *)dict image:(id)image successed:(RequestSuccessed)successed failed:(RequestFailed)failed
{
     NSString * newUrl = [URL_BASE stringByAppendingString:url];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    
    
    [manager POST:newUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"uploadedfile" fileName:[[TimeTool since1970Time] stringByAppendingString:@".png"] mimeType:@"png"];
        NSLog(@"%@",[[TimeTool since1970Time] stringByAppendingString:@".jpg"]);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failed(error);
    }];
}

@end
