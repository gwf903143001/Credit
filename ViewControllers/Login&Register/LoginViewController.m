//
//  LoginViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UIView+BlocksKit.h"
#import "RegisterViewController.h"
#import "AFNHttpTools.h"
#import "ForgetPWDViewController.h"
#import "UserInfoTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "LoginOrNoViewController.h"
#import "CONSTANT.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgimg;

@end

@implementation LoginViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
   
    
}

-(void)viewWillDisappear:(BOOL)animated
{
      self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor blueColor];
    self.bgimg.image = [UIImage imageNamed:@"logins.png"];
    self.iconBtn.layer.cornerRadius = 75;
    self.iconBtn.layer.masksToBounds = YES;
    

    //self.iconBtn.layer.borderColor = [UIColor blueColor].CGColor;
    
    UIImageView * leftView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 45)];
    
    UIView * bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
    
    leftView1.image = [UIImage imageNamed:@"icon_phone"];
    
    [bgView1 addSubview:leftView1];
   
    UIView * bgView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
    
    UIImageView * leftView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 50, 45)];
    
    leftView2.image = [UIImage imageNamed:@"icon_pw"];
    
    [bgView2 addSubview:leftView2];
    
    self.accountTF.leftView = bgView1;
    
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
//    self.accountTF.text = @"789";
    
    self.pwdTF.leftView = bgView2;
//    self.pwdTF.text = @"1";
    
    self.pwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.registerLbl.userInteractionEnabled = YES;
    
    self.forgetPwdLbl.userInteractionEnabled = YES;
    
    __weak LoginViewController * weakSelf = self;
    
    [self.registerLbl bk_whenTapped:^{
        RegisterViewController * regVC = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
        [weakSelf.navigationController pushViewController:regVC animated:YES];
    }];
    
    [self.forgetPwdLbl bk_whenTapped:^{
        ForgetPWDViewController * fogetPwdVC = [[ForgetPWDViewController alloc]initWithNibName:@"ForgetPWDViewController" bundle:nil];
        [weakSelf.navigationController pushViewController:fogetPwdVC animated:YES];
    }];
    
}
- (IBAction)backbutton:(id)sender {
    
    
    LoginOrNoViewController *lonvc = [[LoginOrNoViewController alloc]init];
    [self.navigationController pushViewController:lonvc animated:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"哈哈哈");
    if (textField.tag == 22) {
        self.pwdTF.secureTextEntry = YES;
    }
    CGRect frame = self.view.frame;
    frame.origin.y = - 60;
    
    [UIView animateWithDuration:0.3 animations:^{
        
           self.view.frame = frame;
        
    }];
    
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self resginViewWithTextView:textField];
    
    return YES;
    
}
-(void)resginViewWithTextView:(UITextField *)textField
{
    NSLog(@"哈哈哈----");
    
    CGRect frame = self.view.frame;
    
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = frame;
        [textField resignFirstResponder];
        
    }];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect frame = self.view.frame;
    
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.pwdTF resignFirstResponder];
        [self.accountTF resignFirstResponder];
        self.view.frame = frame;
    }];
    
}

- (IBAction)loginBtnClick {
    if (self.accountTF.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"账号不能为空" maskType:SVProgressHUDMaskTypeNone];
        return;
    }
    if (self.pwdTF.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"密码不能为空" maskType:SVProgressHUDMaskTypeNone];
        return;
    }
    
    [AFNHttpTools requestWithUrl:@"account/login" successed:^(NSDictionary *dict) {
        
        NSLog(@"dict = ------%@",dict);
        NSDictionary * json = [dict objectForKey:@"json"];
        NSDictionary * data = [json objectForKey:@"data"];
        NSString * state = [json objectForKey:@"state"];
        NSString * msg = [json objectForKey:@"msg"];
        NSLog(@"%@", [state class]);
        //        NSString * D_id = [data objectForKey:@"D_id"];
        //       // NSLog(@"%@",D_id);
        //        NSString * msg = [json objectForKey:@"msg"];
        
                [SVProgressHUD showInfoWithStatus:msg];
        
        if (state.integerValue == dStateNormal) {
            NSString * D_id = [data objectForKey:@"D_id"];
            // NSLog(@"%@",D_id);
            NSString *username = self.accountTF.text;
            NSString *password = self.pwdTF.text;
            [UserInfoTool saveUserName:username];
            [UserInfoTool savePWD:password];
            [UserInfoTool saveD_id:D_id];
            
            AppDelegate * app = [AppDelegate shareInstance];
            
            //[app setTabbarController];
        }else if (state.integerValue == dStateLogout){
            [UserInfoTool deleteD_id];
            [UserInfoTool deleteUserName];
            [UserInfoTool deletePWD];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failed:^(NSError *err) {
        [SVProgressHUD showInfoWithStatus:dTips_requestError];
    } andKeyVaulePairs:@"password", self.pwdTF.text, @"account", self.accountTF.text,nil];
}

@end
