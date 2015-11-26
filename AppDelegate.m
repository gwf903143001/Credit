//
//  AppDelegate.m
//  Credit
//
//  Created by iwind on 15/11/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfoTool.h"
#import "UserGuideViewController.h"
#import "MainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+(instancetype)shareInstance
{
    return [[UIApplication sharedApplication] delegate];
    
}

///设置登录页面
//-(void)setLoginViewController
//{
//    LoginViewController * loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    self.window.rootViewController = nc;
//    
//}

//设置是否登陆页面

//-(void)setLoginOrNotViewController{
//    LoginOrNoViewController *LONVC = [[LoginOrNoViewController alloc]init];
//    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:LONVC];
//    self.window.rootViewController = nc;
//}
///设置首页(TabbarController)
-(void)setTabbarController
{
    MainViewController * sb = [[MainViewController alloc]init];
    self.window.rootViewController = sb;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //记录打开次数
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * count = [userDefaults objectForKey:@"count"];
    NSInteger countNum;
    if (nil != count) {
        countNum = count.integerValue;
    }else{
        countNum = 0;
    }
    countNum ++;
    count = [NSString stringWithFormat:@"%ld",(long)countNum];
    NSLog(@"------- count = %@",count);
    //[userDefaults setObject:count forKey:@"count"];
    NSString *d_id = [UserInfoTool getD_id];
    if ([count isEqualToString:@"1"]) {
        UserGuideViewController *userGuideViewController = [[UserGuideViewController alloc] init];
        self.window.rootViewController = userGuideViewController;
    }else if (d_id == nil) {
        //[self setLoginOrNotViewController];
    }else{
        [self setTabbarController];
    }
    [self.window makeKeyAndVisible];
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
