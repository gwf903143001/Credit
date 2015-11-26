//
//  SecurityCenterViewController.m
//  DDViedo
//
//  Created by iwind on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "SecurityCenterViewController.h"
#import "AFNHttpTools.h"
#import "UserInfoTool.h"
#import "CONSTANT.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SecurityCenterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF1;

@property (weak, nonatomic) IBOutlet UITextField *PasswordTF2;
- (IBAction)submitBtn:(UIButton *)sender;




@end

@implementation SecurityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.oldPasswordView
    UIView * leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    label1.text = @"原密码：";
    
    label1.textColor = [UIColor blackColor];
    
    [leftView1 addSubview:label1];
    self.oldPasswordTF.leftView =leftView1;
    self.oldPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    self.oldPasswordTF.placeholder = @"请输入原密码";
    // self.PasswordTF1
    UIView * leftView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    label2.text = @"新密码：";
    
    label2.textColor = [UIColor blackColor];
    
    [leftView2 addSubview:label2];
    self.PasswordTF1.leftView =leftView2;
    self.PasswordTF1.leftViewMode = UITextFieldViewModeAlways;
    self.PasswordTF1.placeholder = @"请输入新密码6～16位";
    
    
    // self.PasswordTF2
    UIView * leftView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 40)];
    label3.text = @"确认新密码：";
    
    label3.textColor = [UIColor blackColor];
    
    [leftView3 addSubview:label3];
    self.PasswordTF2.leftView =leftView3;
    self.PasswordTF2.leftViewMode = UITextFieldViewModeAlways;
    self.PasswordTF2.placeholder = @"请再次输入新密码";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtn:(UIButton *)sender {
    if (![self.PasswordTF1.text isEqualToString:self.PasswordTF2.text]) {
        //[SVProgressHUD showErrorWithStatus:@"新密码前后输入不一致"];
    }else{
        
        [AFNHttpTools requestWithUrl:@"account/modPwd" successed:^(NSDictionary *dict) {
            NSLog(@"------- dict = %@",dict);
            NSDictionary * json = [dict objectForKey:@"json"];
            NSString * state = [json objectForKey:@"state"];
            NSString * msg = [json objectForKey:@"msg"];
            if (state.integerValue == dStateNormal) {
                
                [SVProgressHUD showSuccessWithStatus:msg];
//                [self.navigationController popViewControllerAnimated:YES];
            }else if (state.integerValue == dStateLogout){
                [UserInfoTool deleteD_id];
                [UserInfoTool deleteUserName];
                [UserInfoTool deletePWD];
            }else{
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } failed:^(NSError *err) {
            NSLog(@"------- err = %@",err);
        [SVProgressHUD showSuccessWithStatus:@"连接失败"];
        } andKeyVaulePairs:@"oldPwd",self.oldPasswordTF.text,@"newPwd",self.PasswordTF1.text,@"D_id",[UserInfoTool getD_id], nil];

    
    }
    
}
@end
