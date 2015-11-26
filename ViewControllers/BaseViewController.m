//
//  BaseViewController.m
//  Credit
//
//  Created by iwind on 15/11/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BackButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.BackButton.frame =CGRectMake(20, 20, 40, 30);
    self.BackButton.backgroundColor=[UIColor redColor];
    //按钮事件
    [self.BackButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview: self.BackButton];
    
        //添加 Bar 右边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.BackButton];
    self.navigationItem.leftBarButtonItem = backItem;
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
