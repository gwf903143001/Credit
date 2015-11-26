
//
//  ServerceWebViewController.m
//  DDViedo
//
//  Created by iwind on 15/11/12.
//  Copyright © 2015年 赵 冰冰. All rights reserved.
//

#import "ServerceWebViewController.h"

@interface ServerceWebViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation ServerceWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务条款";
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://119.254.108.212/video/clientapi.php/service/tiaokuan"]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}


- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc]init];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}
    
//    加载完成或失败时，去掉loading效果
-(void)webViewDidFinishLoad:(UIWebView *)webView
    {
        [activityIndicator stopAnimating];
        UIView *view = (UIView*)[self.view viewWithTag:108];
        [view removeFromSuperview];
        NSLog(@"webViewDidFinishLoad");
        
    }
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
     {
        [activityIndicator stopAnimating];
        UIView *view = (UIView*)[self.view viewWithTag:108];
        [view removeFromSuperview];  
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
