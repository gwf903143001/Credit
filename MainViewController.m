//
//  MainViewController.m
//  CreditApp
//
//  Created by iwind on 15/11/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "MainViewController.h"
#import "HomePageViewController.h"
#import "MyViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
        HomePageViewController * HomeVC = [[HomePageViewController alloc]init];
        //首页面
    
        UINavigationController * nc01 = [[UINavigationController alloc]initWithRootViewController:HomeVC];
        //校园tv
        MyViewController * MyVC = [[MyViewController alloc]init];
        UINavigationController * nc02 = [[UINavigationController alloc]initWithRootViewController:MyVC];
        
        NSArray * viewControllers = @[nc01, nc02];
        
        //导航条不透明
        
        NSArray * name = @[@"首页", @"我的"];
        
        NSArray * imgs = @[@"Tab_01_Selected",  @"Tab_03_Selected"];
        
        NSArray * selectedImgs = @[@"Tab_01", @"Tab_03"];
        
        NSInteger i = 0;
        
        for (UINavigationController * nc in viewControllers) {
            //当translucent设置为YES时，导航栏呈现半透明效果 高度会提高64
            nc.navigationBar.translucent = NO;
            //设置bar的文字，默认图片，选中图片
            UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:name[i] image:[UIImage imageNamed:imgs[i]] selectedImage:[UIImage imageNamed:selectedImgs[i]]];
            
            nc.tabBarItem = item;
            
            i++;
            
            
            
        }
        self.viewControllers = viewControllers;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
