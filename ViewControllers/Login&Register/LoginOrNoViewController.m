//
//  LoginOrNoViewController.m
//  DDViedo
//
//  Created by iwind on 15/11/2.
//  Copyright © 2015年 赵 冰冰. All rights reserved.
//

#import "LoginOrNoViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
@interface LoginOrNoViewController ()

@end

@implementation LoginOrNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)LoginOrNotButton:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
- (IBAction)MainviewButton:(id)sender {
    MainViewController *MTBVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:MTBVC animated:YES];
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
