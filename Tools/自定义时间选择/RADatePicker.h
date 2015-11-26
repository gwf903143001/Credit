//
//  RADatePicker.h
//  RAUserMobile
//
//  Created by Richers on 14-4-3.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitButtonView.h"

@protocol RAGetPickDate <NSObject>

-(void)getPickDate:(NSString *)dateString;

@end

@interface RADatePicker : UIView
{
    BOOL stButtonChange;
    BOOL etButtonChange;
    
    UIView * pickBGView;
    UIDatePicker * picview;
    SubmitButtonView * selectButton;
    
    UIView * dateView;
    UIView * datebgView ;
    
    UITextField * stdateTextField;
    UIButton * stdateButton;
    
    UITextField * etdateTextField;
    UIButton * etdateButton;
    
    NSString * stDateString;
    NSString * etDateString;
    
    UILabel * timeLabel;
}

@property (nonatomic,assign)NSInteger state;
@property (nonatomic,strong) id <RAGetPickDate> pickDelegate;

@end
