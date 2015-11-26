//
//  RADatePicker.m
//  RAUserMobile
//
//  Created by Richers on 14-4-3.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import "RADatePicker.h"
#import "UIColor+AddColor.h"

@implementation RADatePicker

@synthesize state;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self ViewDidLoad];
    }
    return self;
}

-(void)ViewDidLoad
{
    [self dateClienk];
}

-(void)dateClienk
{
    pickBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //if (IOS7) {
       // pickBGView.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20);
   // }
    pickBGView.backgroundColor = [UIColor clearColor];
    [self addSubview:pickBGView];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1);
    line.backgroundColor = [UIColor grayColor];
    [pickBGView addSubview:line];
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 40);
    view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [pickBGView addSubview:view];
    
    
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"%@",locationString);
    //设置时间选择器
    NSDate * minDate = [self StringToDate:locationString];
//    NSDate * maxDate = [self StringToDate:@"20371231"];
    NSDate *nowDate = [NSDate date];
    picview = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80, self.frame.size.width, 200)];
    picview.backgroundColor = [UIColor whiteColor];
//    picview.minuteInterval = 1;
    picview.minimumDate = minDate;
//    picview.maximumDate = maxDate;
    [picview.locale setAccessibilityLanguage:NSCalendarIdentifierChinese];
    [picview setCountDownDuration:1];
    [picview setDate:nowDate];
    picview.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [picview setDatePickerMode:UIDatePickerModeDate];
    [self addSubview:picview];

    //时间选择
    selectButton = [[SubmitButtonView alloc]initWithFrame:CGRectMake(self.frame.size.width-60,55, 40, 20)];
    selectButton.nameLabel.text = @"确定";
    [selectButton.submitButton addTarget:self action:@selector(selectClienk) forControlEvents:UIControlEventTouchUpInside];
    selectButton.layer.cornerRadius = 4;
    selectButton.backgroundColor = [UIColor colorWithHexString:@"#f07801"];
    [self addSubview:selectButton];
}

//字符串转化为时间格式
-(NSDate *)StringToDate:(NSString *)dateString
{
    NSString* string = dateString;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}

//选择时间选择器选中的时间 再赋值给UITextField上  关闭弹出式 模拟框
-(void)selectClienk
{
    NSDate *selected = [picview date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitHour| NSCalendarUnitMinute| NSCalendarUnitSecond;

    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:selected];
    
    if (state == 1) {
        [self.pickDelegate getPickDate:[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)[dateComponent year],(long)[dateComponent month],(long)[dateComponent day]]];
    }else{
        [self.pickDelegate getPickDate:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)[dateComponent year],(long)[dateComponent month],(long)[dateComponent day]]];
    }
    [pickBGView removeFromSuperview];
    [picview removeFromSuperview];
    [selectButton removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
