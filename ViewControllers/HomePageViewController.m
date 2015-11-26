//
//  HomePageViewController.m
//  Credit
//
//  Created by iwind on 15/11/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "HomePageViewController.h"
#import "secondViewController.h"
#import "TimeTool.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *timeString = @"20140920";
     NSString *date = [TimeTool timeStrTransverterSince1970Time:timeString];
//    NSString *ee = [TimeTool dateToString:date];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextbutton:(id)sender {
    secondViewController *svc = [[secondViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
    
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
