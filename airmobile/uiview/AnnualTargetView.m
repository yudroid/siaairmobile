//
//  AnnualTargetView.m
//  KaiYa
//
//  Created by WangShiran on 16/2/29.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "AnnualTargetView.h"
#import "POP.h"


@implementation AnnualTargetView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, kScreenWidth, 18)];//页面title
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        titleLabel.text = @"2016年度航班指标";
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        
        
        progressRound = [[ProductionProgressRound alloc] initWithCenter:CGPointMake(kScreenWidth/2, 161)];
        [self addSubview:progressRound];
        [progressRound animationWithStrokeEnd:0.5 securityProgreesType:ProductionProgreesTypeActual];
        [progressRound animationWithStrokeEnd:0.6 securityProgreesType:ProductionProgreesTypePlan];
        
        annualPlanNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];//正常数值
        annualPlanNumLabel.center = CGPointMake(kScreenWidth/2-115, 325);
        annualPlanNumLabel.text = @"";
        annualPlanNumLabel.textAlignment = NSTextAlignmentCenter;
        annualPlanNumLabel.textColor = [CommonFunction colorFromHex:0XFF9EB9DE];
        annualPlanNumLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:annualPlanNumLabel];
        
        [self labelAnimationWithLabel:annualPlanNumLabel TextNumber:32800];
        
        UILabel *normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 18)];//正常
        normalLabel.center = CGPointMake(kScreenWidth/2-115, 355);
        normalLabel.textAlignment = NSTextAlignmentCenter;
        normalLabel.textColor = [CommonFunction colorFromHex:0XFF9EB9DE];
        normalLabel.text = @"年度计划";
        //兼容ios10字体变化
        if([CommonFunction iOSVersion10]){
            normalLabel.font = [UIFont systemFontOfSize:14];
        }else{
            normalLabel.font = [UIFont systemFontOfSize:15];
        }
        [self addSubview:normalLabel];
        
        UIView *leftLine = [CommonFunction addLine:CGRectMake(0, 0, 1, 40) color:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
        leftLine.center = CGPointMake(kScreenWidth/2-55, 337);
        [self addSubview:leftLine];
        
        planFinishNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];//正常数值
        planFinishNumLabel.center = CGPointMake(kScreenWidth/2, 325);
        planFinishNumLabel.textAlignment = NSTextAlignmentCenter;
        planFinishNumLabel.text = @"12000";
        planFinishNumLabel.textColor = [CommonFunction colorFromHex:0XFFE080FF];
        planFinishNumLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:planFinishNumLabel];
        
        [self labelAnimationWithLabel:planFinishNumLabel TextNumber:12000];
        
        UILabel *delayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];//异常
        delayLabel.center = CGPointMake(kScreenWidth/2, 355);
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
        rightLine.center = CGPointMake(kScreenWidth/2+55, 337);
        [self addSubview:rightLine];
        
        finishedNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 36)];//正常数值
        finishedNumLabel.center = CGPointMake(kScreenWidth/2+110, 325);
        finishedNumLabel.text = @"9800";
        finishedNumLabel.textAlignment = NSTextAlignmentCenter;
        finishedNumLabel.textColor = [CommonFunction colorFromHex:0XFF00EF8C];
        finishedNumLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:finishedNumLabel];
        
        [self labelAnimationWithLabel:finishedNumLabel TextNumber:9800];
        
        UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 18)];//正常
        cancelLabel.center = CGPointMake(kScreenWidth/2+110, 355);
        cancelLabel.textAlignment = NSTextAlignmentCenter;
        cancelLabel.textColor = [CommonFunction colorFromHex:0XFF00EF8C];
        cancelLabel.text = @"已完成";
        //兼容ios10字体变化
        if([CommonFunction iOSVersion10]){
            cancelLabel.font = [UIFont systemFontOfSize:14];
        }else{
            cancelLabel.font = [UIFont systemFontOfSize:15];
        }
        [self addSubview:cancelLabel];
        
        unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-18, kScreenWidth, 18)];//正常
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.textColor = [CommonFunction colorFromHex:0XFF9EB9DE];
        unitLabel.text = @"单位:架次";
//        unitLabel.backgroundColor = [UIColor yellowColor];
        unitLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:unitLabel];

        
        if ([DeviceInfoUtil IphoneVersions]==6.5)
        {
            titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 18);

        }
    }
    
    return self;
}

#pragma mark Set方法

-(void)setTitleText:(NSString *)titleText
{
    titleLabel.text = titleText;
}

-(void)setUnitLabelText:(NSString *)unitLabelText
{
    unitLabel.text = unitLabelText;
}

-(void)setAnnualPlanProportion:(CGFloat)annualPlanProportion
{
    [progressRound animationWithStrokeEnd:annualPlanProportion securityProgreesType:ProductionProgreesTypeActual];
}


-(void)setPlanFinishProportion:(CGFloat)planFinishProportion
{
    [progressRound animationWithStrokeEnd:planFinishProportion securityProgreesType:ProductionProgreesTypePlan];
}

-(void)setAnnualPlanNum:(CGFloat)annualPlanNum
{
    [self labelAnimationWithLabel:annualPlanNumLabel TextNumber:annualPlanNum];
}

-(void)setPlanFinishNum:(CGFloat)planFinishNum
{
    [self labelAnimationWithLabel:planFinishNumLabel TextNumber:planFinishNum];
}

-(void)setFinishedNum:(CGFloat)finishedNum
{
    [self labelAnimationWithLabel:finishedNumLabel TextNumber:finishedNum];
}

-(void)setIsUp:(BOOL)isUp
{
    progressRound.isUp = isUp;
}

-(void)setProgressRoundPlanNum:(CGFloat)progressRoundPlanNum
{
    progressRound.planNum = progressRoundPlanNum;
}

#pragma mark 动画实现

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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
