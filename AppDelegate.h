//
//  AppDelegate.h
//  Credit
//
//  Created by iwind on 15/11/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
///返回app代理
+(instancetype)shareInstance;
///设置登录界面
-(void)setLoginViewController;
///设置tabbar界面
-(void)setTabbarController;
@end

