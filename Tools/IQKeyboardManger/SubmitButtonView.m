//
//  SubmitButtonView.m
//  RAUserMobile
//
//  Created by Richers on 14-3-27.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import "SubmitButtonView.h"

@implementation SubmitButtonView

@synthesize nameLabel,submitButton;

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
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.frame.size.height)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [UIColor clearColor];//ToolClass colorWithHexString:@"#f07801"
    nameLabel.layer.cornerRadius = 4;
//   / nameLabel.font = [UIFont fontWithName:nil size:13];
    [self addSubview:nameLabel];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.frame.size.height);
    submitButton.layer.cornerRadius = 4;
    submitButton.backgroundColor = [UIColor clearColor];
    [self addSubview:submitButton];
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
