//
//  MonthlyProgressRound.m
//  KaiYa
//
//  Created by WangShiran on 16/3/1.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#define degreesToRadians(x) (M_PI*(x)/180.0)

#import "MonthlyProgressRound.h"
#import "POP.h"

@implementation MonthlyProgressRound

-(id)initWithCenter:(CGPoint)center
{
    self = [super initWithFrame:CGRectMake(0, 0, 187, 187)];
    
    if (self)
    {
        //        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示范围
        
        UIImageView *bigImage = [CommonFunction imageView:@"productionround_big.png" frame:CGRectMake(0, 0, 187, 187)];
        bigImage.center = self.center;
        [self addSubview:bigImage];
        
        [self configCircle];
        
        ActualNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
        ActualNumLabel.center = self.center;
        ActualNumLabel.textAlignment = NSTextAlignmentCenter;
        ActualNumLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        ActualNumLabel.text = @"54%";
        ActualNumLabel.font = [UIFont systemFontOfSize:36];
        [self addSubview:ActualNumLabel];
        
        [self labelAnimationWithLabel:ActualNumLabel TextNumber:54];
        
        self.center = center;
    }
    
    return self;
}

-(void)configCircle
{
    self.normalLaber = [CAShapeLayer layer];
    
    CGFloat lineWidth = 17.0f;
    
    UIBezierPath * bez2 = [UIBezierPath bezierPathWithArcCenter:self.center radius:85 startAngle:degreesToRadians(270) endAngle:degreesToRadians(271) clockwise:NO];
    self.normalLaber.strokeColor = [CommonFunction colorFromHex:0XFF00F383].CGColor;//self.lineColor.CGColor;
    self.normalLaber.path = bez2.CGPath;
    self.normalLaber.fillColor = nil;
    self.normalLaber.lineJoin = kCALineJoinRound;
    self.normalLaber.lineCap =kCALineCapRound;
    self.normalLaber.lineWidth = lineWidth;
    [self.layer addSublayer:self.normalLaber];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];//颜色渐变
    gradientLayer.frame = self.frame;
    gradientLayer.colors = @[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ];
    gradientLayer.startPoint = CGPointMake(0,0.5);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.normalLaber;
    
}

#pragma mark 动画实现
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd
{
    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    bAni.fromValue = @(0);
    bAni.toValue = @(strokeEnd);
    bAni.duration = 2;//动画持续时间
    bAni.removedOnCompletion = NO;
    
    [self.normalLaber pop_addAnimation:bAni forKey:@"NormoalAnimation"];
    
    [self labelAnimationWithLabel:ActualNumLabel TextNumber:strokeEnd*100];
}


-(void)labelAnimationWithLabel:(UILabel *)label TextNumber:(NSInteger)number
{
    POPBasicAnimation * labelBani = [POPBasicAnimation animation];
    labelBani.duration =2;//动画持续时间
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        [prop setReadBlock:^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        }];
        [prop setWriteBlock:^(id obj, const CGFloat values[]) {
            NSString * str =[NSString stringWithFormat:@"%.f",values[0]];
            [obj setText:[NSString stringWithFormat:@"%@%%",str]];
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
