//
//  UserGuideViewController.m
//  DDViedo
//
//  Created by iwind on 15/11/4.
//  Copyright © 2015年 赵 冰冰. All rights reserved.
//

#import "UserGuideViewController.h"
#import "MainViewController.h"
@interface UserGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pagecontroll;
@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGuide];   //加载新用户指导页面
    // Do any additional setup after loading the view.
}
- (void)initGuide{
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width*4, 0)];
        [scrollView setPagingEnabled:YES];  //视图整页显示
         scrollView.delegate = self;
         //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
         UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [imageview setImage:[UIImage imageNamed:@"g1.png"]];
        [scrollView addSubview:imageview];

    
        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
         [imageview1 setImage:[UIImage imageNamed:@"g2.png"]];
         [scrollView addSubview:imageview1];
    
         UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
         [imageview2 setImage:[UIImage imageNamed:@"g3.png"]];
        [scrollView addSubview:imageview2];

        UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*3, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [imageview3 setImage:[UIImage imageNamed:@"g4.png"]];
        imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
        [scrollView addSubview:imageview3];
    
    
         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
        [button setTitle:nil forState:UIControlStateNormal];
         [button setFrame:CGRectMake(self.view.center.x-60, self.view.frame.size.height-90, 120, 40)];
         [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageview3 addSubview:button];
    
    
    self.pagecontroll = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.center.x-40, self.view.frame.size.height-30, 80, 20)];
    //self.pagecontroll.backgroundColor = [UIColor grayColor];
    self.pagecontroll.numberOfPages = 4;
    self.pagecontroll.currentPage = 0;
    [self.view addSubview:scrollView];
    [self.view addSubview:self.pagecontroll];
  }

 - (void)firstpressed
   {
       UITabBarController *MTBVC = [[UITabBarController alloc]init];
       UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:MTBVC];
       [self presentViewController:nc animated:YES completion:nil];

    }

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    self.pagecontroll.currentPage = index;
    
}                                              // any offset changes

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
