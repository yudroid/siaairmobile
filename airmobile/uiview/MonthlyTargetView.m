//
//  MonthlyTargetView.m
//  KaiYa
//
//  Created by WangShiran on 16/3/1.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "MonthlyTargetView.h"
#import "POP.h"
#import "DeviceInfoUtil.h"

@implementation MonthlyTargetView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, kScreenWidth, 18)];//页面title
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        titleLabel.text = @"";
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        
        secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24+20, kScreenWidth, 16)];
        secondTitleLabel.textAlignment = NSTextAlignmentCenter;
        secondTitleLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        secondTitleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:secondTitleLabel];
        
        progressRound = [[MonthlyProgressRound alloc] initWithCenter:CGPointMake(kScreenWidth/2, 161)];
        [self addSubview:progressRound];
        [progressRound animationWithStrokeEnd:0.6];
        
        monthlyPlanNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];//正常数值
        monthlyPlanNumLabel.center = CGPointMake(kScreenWidth/2-60, 325);
        monthlyPlanNumLabel.textAlignment = NSTextAlignmentCenter;
        monthlyPlanNumLabel.text = @"12000";
        monthlyPlanNumLabel.textColor = [CommonFunction colorFromHex:0XFFE080FF];
        monthlyPlanNumLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:monthlyPlanNumLabel];
        
        [self labelAnimationWithLabel:monthlyPlanNumLabel TextNumber:12000];
        
        UILabel *delayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];//异常
        delayLabel.center = CGPointMake(kScreenWidth/2-60, 355);
        delayLabel.textAlignment = NSTextAlignmentCenter;
        delayLabel.textColor = [CommonFunction colorFromHex:0XFFE080FF];
        delayLabel.text = @"计划完成";
        //兼容ios10字体变化
        if([CommonFunction iOSVersion10]){
            delayLabel.font = [UIFont systemFontOfSize:14];
        }else{
            delayLabel.font = [UIFont systemFontOfSize:15];
        }
        [self addSubview:delayLabel];
        
        UIView *rightLine = [CommonFunction addLine:CGRectMake(0, 0, 1, 40) color:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
        rightLine.center = CGPointMake(kScreenWidth/2, 337);
        [self addSubview:rightLine];
        
        finishedNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];//正常数值
        finishedNumLabel.center = CGPointMake(kScreenWidth/2+60, 325);
        finishedNumLabel.text = @"9800";
        finishedNumLabel.textAlignment = NSTextAlignmentCenter;
        finishedNumLabel.textColor = [CommonFunction colorFromHex:0XFF00EF8C];
        finishedNumLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:finishedNumLabel];
        
        [self labelAnimationWithLabel:finishedNumLabel TextNumber:9800];
        
        UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 18)];//正常
        cancelLabel.center = CGPointMake(kScreenWidth/2+60, 355);
        cancelLabel.textAlignment = NSTextAlignmentCenter;
        cancelLabel.textColor = [CommonFunction colorFromHex:0XFF00EF8C];
        cancelLabel.text = @"已完成";
        //兼容ios10字体变化
        if([CommonFunction iOSVersion10]){
            delayLabel.font = [UIFont systemFontOfSize:14];
        }else{
            delayLabel.font = [UIFont systemFontOfSize:15];
        }
        [self addSubview:cancelLabel];
        
        unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-18, kScreenWidth, 18)];//正常
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.textColor = [CommonFunction colorFromHex:0XFF9EB9DE];
        unitLabel.text = @"单位:架次";
        unitLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:unitLabel];
        
        if ([DeviceInfoUtil IphoneVersions]==6.5)
        {
            titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 18);
            secondTitleLabel.frame = CGRectMake(0, 26, kScreenWidth, 18);
        }
    }
    
    return self;
}

#pragma mark 动画实现

-(void)setUnitLabelText:(NSString *)unitLabelText
{
    unitLabel.text = unitLabelText;
}

-(void)labelAnimationWithLabel:(UILabel *)label TextNumber:(CGFloat)number
{
    POPBasicAnimation * labelBani = [POPBasicAnimation animation];
    labelBani.duration =2;//动画持续时间
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        [prop setReadBlock:^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        }];
        [prop setWriteBlock:^(id obj, const CGFloat values[]) {
            NSString * str = @"";
            if(_labelFlag==0){
                str =[NSString stringWithFormat:@"%.0f",values[0]];
            }else{
                str =[NSString stringWithFormat:@"%.2f",values[0]];
            }
            [obj setText:[NSString stringWithFormat:@"%@",str]];
        }];
        prop.threshold = 0.01;
    }];
    labelBani.property = prop;
    labelBani.fromValue = @(0);
    labelBani.toValue = @(number);
    [label pop_addAnimation:labelBani forKey:@"123"];
}

#pragma mark Set方法

-(void)setTitleText:(NSString *)titleText
{
    titleLabel.text = titleText;
}

-(void)setSecondTitleText:(NSString *)titleText
{
    secondTitleLabel.text = titleText;
}


-(void)setMonthlyPlanNum:(CGFloat)monthlyPlanNum
{
    [self labelAnimationWithLabel:monthlyPlanNumLabel TextNumber:monthlyPlanNum];
}

-(void)setFinishedNum:(CGFloat)finishedNum
{
    [self labelAnimationWithLabel:finishedNumLabel TextNumber:finishedNum];
}

-(void)setProportion:(CGFloat)proportion
{
    [progressRound animationWithStrokeEnd:proportion];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
