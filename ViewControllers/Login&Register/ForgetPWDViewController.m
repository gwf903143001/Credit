//
//  ForgetPWDViewController.m
//  DDViedo
//
//  Created by iwind on 15/3/23.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "ForgetPWDViewController.h"
#import "RegTools.h"
#import "AFNHttpTools.h"
#import "UserInfoTool.h"
#import "CONSTANT.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface ForgetPWDViewController () <UITextFieldDelegate>
{
int surplus;
}
@property (weak, nonatomic) IBOutlet UITextField *inputUserName;
@property (weak, nonatomic) IBOutlet UITextField *InputEmail;
- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputAuthCode;
- (IBAction)sendAuthCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *AuthCodeButton;

@property (weak, nonatomic) IBOutlet UITextField *NewPWD1;
@property (weak, nonatomic) IBOutlet UITextField *NewPWD2;
@property(strong ,nonatomic)NSTimer *mytimer;
@end

@implementation ForgetPWDViewController


//页面将要进入前台，开启定时器
-(void)viewWillAppear:(BOOL)animated
{
    //开启定时器
    [self.mytimer setFireDate:[NSDate distantPast]];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
    [self.mytimer setFireDate:[NSDate distantFuture]];
}
-(void)dingshiqi{
   self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
}
- (void)timerFire:(NSTimer *)timer
{
    //倒计时时间
    
    if (surplus==0) {
        [self.AuthCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.AuthCodeButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        self.AuthCodeButton.enabled = YES;
        surplus = 9;
        [timer setFireDate:[NSDate distantFuture]];
        
    }else{
        --surplus;
        [self.AuthCodeButton setTitle:[NSString stringWithFormat:@"%d",surplus] forState:UIControlStateNormal];
        self.AuthCodeButton.enabled = NO;
        
    }
    NSLog(@"%d",surplus);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.oldPasswordView
//    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 30)];
//    [backbutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    self.title = @"忘记密码";
    surplus = 9;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.500 alpha:1.000];
    
    UIView * UserNameLv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    label1.text = @"账号：";
    
    label1.textColor = [UIColor blackColor];
    
    [UserNameLv addSubview:label1];
    self.inputUserName.leftView =UserNameLv;
    self.inputUserName.leftViewMode = UITextFieldViewModeAlways;
    self.inputUserName.placeholder = @"请输入账号";
    // self.PasswordTF1
    UIView * emailLv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    label2.text = @"邮箱：";
    
    label2.textColor = [UIColor blackColor];
    
    [emailLv addSubview:label2];
    self.InputEmail.leftView =emailLv;
//    self.InputEmail.text = @"hanyang@iwind-tech.com";
    self.InputEmail.leftViewMode = UITextFieldViewModeAlways;
    self.InputEmail.placeholder = @"请输入注册邮箱";
    
    
    // self.PasswordTF2
    //    UIView * authLv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //    label3.text = @"验证码：";
    //
    //    label3.textColor = [UIColor blackColor];
    //
    //    [authLv addSubview:label3];
    //    self.inputAuthCode.leftView =authLv;
    self.inputAuthCode.leftViewMode = UITextFieldViewModeAlways;
    self.inputAuthCode.placeholder = @"请输入验证码";
    
    UIView * newPwd1Lv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    UILabel * label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 40)];
    label4.text = @"新密码：";
    
    label4.textColor = [UIColor blackColor];
    
    [newPwd1Lv addSubview:label4];
    self.NewPWD1.leftView =newPwd1Lv;
    self.NewPWD1.leftViewMode = UITextFieldViewModeAlways;
    self.NewPWD1.placeholder = @"请输入新密码";
    
    UIView * newPwd2Lv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    UILabel * label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 40)];
    label5.text = @"确认密码：";
    
    label5.textColor = [UIColor blackColor];
    
    [newPwd2Lv addSubview:label5];
    self.NewPWD2.leftView =newPwd2Lv;
    self.NewPWD2.leftViewMode = UITextFieldViewModeAlways;
    self.NewPWD2.placeholder = @"请再次输入密码";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submitBtn:(id)sender {
  //  NSMutableDictionary * param = [NSMutableDictionary dictionary];
    if (![@"" isEqualToString:self.inputUserName.text]&&![@"" isEqualToString:self.inputAuthCode.text]&&![@"" isEqualToString: self.InputEmail.text] && ![@"" isEqualToString:self.NewPWD1.text] && ![@"" isEqualToString:self. NewPWD2.text]){
        if ([RegTools regResultWithMyMail:self.InputEmail.text] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确邮箱格式"];
        }else if (![self.NewPWD1.text isEqualToString:self.NewPWD2.text]){
            [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        }else{
            
            [AFNHttpTools requestWithUrl:@"account/findPwd" successed:^(NSDictionary *dict) {
                NSLog(@"------- dict = %@",dict);
                NSDictionary * json = [dict objectForKey:@"json"];
                NSString * state = [json objectForKey:@"state"];
                NSString * msg = [json objectForKey:@"msg"];
                if (state.integerValue == dStateNormal) {
                    [SVProgressHUD showSuccessWithStatus:msg];
                    [self.navigationController popViewControllerAnimated:YES];
                }else if (state.integerValue == dStateLogout){
                    [UserInfoTool deleteD_id];
                    [UserInfoTool deleteUserName];
                    [UserInfoTool deletePWD];
                }else{
                    [SVProgressHUD showErrorWithStatus:msg];
                }
                
                
            } failed:^(NSError *err) {
                [SVProgressHUD showErrorWithStatus:@"连接失败"];
            } andKeyVaulePairs:@"account",self.inputUserName.text ,@"email",self.InputEmail.text,@"code",self.inputAuthCode.text,@"newPwd",self.NewPWD2.text,@"D_id",[UserInfoTool getD_id], nil];
            
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入全部信息"];
    }
    
}
- (IBAction)sendAuthCode:(UIButton *)sender {
    if ([RegTools regResultWithMyMail:self.InputEmail.text] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确邮箱格式"];
    }else{
        
        
        [AFNHttpTools requestWithUrl:@"account/sendCode" successed:^(NSDictionary *dict) {
            NSDictionary * json = [dict objectForKey:@"json"];
            NSString * state = [json objectForKey:@"state"];
            NSString * msg = [json objectForKey:@"msg"];
            NSLog(@" ------- dict = %@",dict);
            if (state.integerValue == dStateNormal) {
                [SVProgressHUD showSuccessWithStatus:msg];
                [self dingshiqi];
            }else if (state.integerValue == dStateLogout){
                [UserInfoTool deleteD_id];
                [UserInfoTool deleteUserName];
                [UserInfoTool deletePWD];
            }else{
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } failed:^(NSError *err) {
            [SVProgressHUD showErrorWithStatus:@"连接失败"];
        } andKeyVaulePairs:@"account",self.inputUserName.text,@"email",self.InputEmail.text, nil];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"hehehhe");
    [textField resignFirstResponder];
    return true;
}
@end
