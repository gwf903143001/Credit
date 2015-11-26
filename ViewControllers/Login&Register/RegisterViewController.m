//
//  RegisterViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#import "RegisterViewController.h"
#import "AFNHttpTools.h"
#import "RegTools.h"
#import "UIView+BlocksKit.h"
#import "UserInfoTool.h"
#import "CONSTANT.h"
#import "ServerceWebViewController.h"
#import "MBProgressHUD.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
 UIWebView *webView;
    
}

@property (nonatomic, strong) MBProgressHUD *progressBox;

@property (nonatomic, strong) UIScrollView * bgScrollView;

@property (nonatomic, strong) NSMutableArray * textArray;

@property (nonatomic, strong) UIButton * selectBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"快速注册";
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:0.604 alpha:1.000];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0.500 alpha:1.000];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * name = @[@"输 入 学 号", @"输 入 密 码", @"输 入 确 认 密 码", @"输 入 昵 称",@"输 入 邮 箱", @"输 入 姓 名", @"输 入 手 机 号"];
    NSArray * labname = @[@"学号:", @"密码:", @"确认密码:", @"昵称:",@"邮箱:", @"姓名:", @"手机号:"];
    
    self.progressBox = [[MBProgressHUD alloc]initWithFrame:self.view.frame];
    self.progressBox.mode = MBProgressHUDModeText;
    self.textArray = [[NSMutableArray alloc]init];
    
    CGRect frame = CGRectZero;
    
    for (NSInteger i = 0; i < name.count; i++) {
        
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(82, 64+7 + i * 44, kMainScreenWidth - 100, 37)];
        tf.placeholder = name[i];
        
        tf.borderStyle = UITextBorderStyleRoundedRect;
        
        tf.delegate = self;
        
        tf.tag = kMaxTag + i;
        
        [self.view addSubview:tf];
        
        
        
        UILabel * lf = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+7 + i * 44, 80, 37)];
        lf.text = labname[i];
        [self.view addSubview:lf];
        
        if (i == name.count - 1) {
            
            frame = tf.frame;
        }
        [self.textArray addObject:tf];
    }
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(30, frame.origin.y+70, 25, 25);
    [self.selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn setImage:[UIImage imageNamed:@"btn_check_off.png"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"btn_check_on.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.selectBtn];
    
    UILabel * textla = [[UILabel alloc]initWithFrame:CGRectMake(100, frame.origin.y+38 , kMainScreenWidth - CGRectGetMaxX(self.selectBtn.frame) - 180, 25)];
    textla.text = @"视频平台服务条款";
    
    textla.textColor = [UIColor blueColor];
    textla.userInteractionEnabled = YES;
    [self.view addSubview:textla];
    
    UILabel *linelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(textla.frame), CGRectGetMaxY(textla.frame)+2, textla.frame.size.width, 1)];
    linelab.backgroundColor = [UIColor blueColor];
    [self.view addSubview:linelab];
    
    [textla bk_whenTapped:^{
        NSLog(@"视频条款");
        ServerceWebViewController *swvc = [[ServerceWebViewController alloc]init];
        
        [self.navigationController pushViewController:swvc animated:YES];
    }];
    UILabel * la = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectBtn.frame) + 10, CGRectGetMinY(self.selectBtn.frame) , kMainScreenWidth - CGRectGetMaxX(self.selectBtn.frame) - 100, 25)];
    la.text = @"同意以上协议";
    la.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:la];
    
    UIButton * regBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(la.frame) + 20, kMainScreenWidth - 40, 37)];
    
    [self.view addSubview:regBtn];
    
    [regBtn addTarget:self action:@selector(regBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [regBtn setBackgroundImage:[UIImage imageNamed:@"btn_reg_o.png"] forState:UIControlStateNormal];
    [regBtn setTitle:@"注 册" forState:UIControlStateNormal];
}

-(void)regBtnClick:(UIButton *)button
{
    if (self.selectBtn.selected == YES) {
        UITextField * account = [self.textArray objectAtIndex:0];
        UITextField * pwd = [self.textArray objectAtIndex:1];
        UITextField * cofirmPwd = [self.textArray objectAtIndex:2];
        UITextField * nickName = [self.textArray objectAtIndex:3];
        UITextField * myMail = [self.textArray objectAtIndex:4];
        UITextField * name = [self.textArray objectAtIndex:5];
        UITextField * phoneNum = [self.textArray objectAtIndex:6];
        
        
        NSArray * nameArr = @[@"学号", @"密码", @"确认密码", @"昵称",@"邮箱", @"姓名", @"手机号"];
        
        
        NSLog(@"ddd");
        
        NSInteger i = 0;
        
        
        for (UITextField * tf in self.textArray) {
            
            if (tf.text.length == 0) {
                
                NSString * msg = [nameArr objectAtIndex:i];
                
                msg = [msg stringByAppendingString:@"没有填写"];
                self.progressBox.labelText = msg;
                [self.progressBox show:YES];
                
                return;
            }
            i++;
        }
        
        if (![cofirmPwd.text isEqualToString:pwd.text]) {
            
            self.progressBox.labelText = @"两次密码输入不一致";
            [self.progressBox show:YES];

            
            return;
            
        }
        
        if (![RegTools regResultWithString:phoneNum.text]) {
            
           // [SVProgressHUD showErrorWithStatus:@"手机号码格式不正确"];
            self.progressBox.labelText = @"手机号码格式不正确";
            [self.progressBox show:YES];
            return;
        }
        
        if (![RegTools regResultWithMyMail:myMail.text]) {
            
            //[SVProgressHUD showErrorWithStatus:@"邮箱格式不正确"];
            self.progressBox.labelText = @"邮箱格式不正确";
            [self.progressBox show:YES];
            return;
        }
        
        [AFNHttpTools requestWithUrl:@"account/register" successed:^(NSDictionary *dict) {
            
            NSDictionary * json = [dict objectForKey:@"json"];
            //        NSLog(@"%@",json);
            
            NSString  * state = [json objectForKey:@"state"];
            NSString * msg = [json objectForKey:@"msg"];
            //        NSLog(@"------ msg = %@",msg);
            if (state.integerValue == dStateNormal) {
                self.progressBox.labelText = msg;
                [self.progressBox show:YES];
                //[SVProgressHUD showSuccessWithStatus:msg];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else if (state.integerValue == dStateLogout){
                [UserInfoTool deleteD_id];
                [UserInfoTool deleteUserName];
                [UserInfoTool deletePWD];
            }else{
                self.progressBox.labelText = msg;
                [self.progressBox show:YES];

                //[SVProgressHUD showErrorWithStatus:msg];
            }
            
            
            
        } failed:^(NSError *err) {
            
            NSLog(@"%@", err);
            self.progressBox.labelText = @"连接失败";
            [self.progressBox show:YES];

            //[SVProgressHUD showErrorWithStatus:@"连接失败"];
            
        } andKeyVaulePairs:@"account", account.text, @"pwd", pwd.text, @"email", myMail.text, @"name", name.text, @"tel", phoneNum.text,@"nickName", nickName.text, nil];
    }else{
        self.progressBox.labelText = @"请先同意协议";
        [self.progressBox show:YES];

        //[SVProgressHUD showErrorWithStatus:@"请先同意协议"];
    }
    
}
#pragma mark - 我同意协议
-(void)btnClick:(UIButton *)button
{
    NSLog(@"我同意");
    button.selected = !button.selected;
}

#pragma mark - TextFieldDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"哈哈哈");
    
    
    
    if (textField.tag == kMaxTag +4 || textField.tag == kMaxTag +5 || textField.tag == kMaxTag +6) {
        CGRect frame = self.view.frame;
        
        frame.origin.y = - 60;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = frame;
            
        }];
    }
    
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
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        [(UITextField*)[weakSelf.textArray objectAtIndex:0] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:1] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:2] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:3] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:4] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:5] resignFirstResponder];
        [(UITextField*)[weakSelf.textArray objectAtIndex:6] resignFirstResponder];
        weakSelf.view.frame = frame;
    }];
    
}

@end
