//
//  ProductionProgressRound.m
//  KaiYa
//
//  Created by WangShiran on 16/2/29.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式


#import "ProductionProgressRound.h"
#import "POP.h"

@implementation ProductionProgressRound

-(id)initWithCenter:(CGPoint)center
{
    self = [super initWithFrame:CGRectMake(0, 0, 187, 187)];
    
    if (self)
    {
        //        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示范围
        
        UIImageView *bigImage = [CommonFunction imageView:@"productionround_big.png" frame:CGRectMake(0, 0, 187, 187)];
        bigImage.center = self.center;
        [self addSubview:bigImage];
        
        UIImageView *smallImage = [CommonFunction imageView:@"productionround_small.png" frame:CGRectMake(0, 0, 149, 149)];
        smallImage.center = self.center;
        [self addSubview:smallImage];
        
        [self configCircle];
        
        UILabel *ActualLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
        ActualLabel.center = CGPointMake(self.center.x-8, 10);
        ActualLabel.textAlignment = NSTextAlignmentCenter;
        ActualLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        ActualLabel.text = @"实际";
        ActualLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:ActualLabel];
        
        UILabel *planLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
        planLabel.center = CGPointMake(self.center.x-8, 30);
        planLabel.textAlignment = NSTextAlignmentCenter;
        planLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        planLabel.text = @"计划";
        planLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:planLabel];

        UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
        centerLabel.center = CGPointMake(self.center.x, self.center.y-30);
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
        centerLabel.text = @"实际";
        centerLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:centerLabel];
        
        ActualNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
        ActualNumLabel.center = self.center;
        ActualNumLabel.textAlignment = NSTextAlignmentCenter;
        ActualNumLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        ActualNumLabel.text = @"54%";
        ActualNumLabel.font = [UIFont systemFontOfSize:36];
        [self addSubview:ActualNumLabel];
        
        arrow = [CommonFunction imageView:@"icon_down.png" frame:CGRectMake(0, 0, 6, 11)];
        arrow.center = CGPointMake(self.center.x-8, self.center.y+30);
        [self addSubview:arrow];
        
        planNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12)];
        planNumLabel.center = CGPointMake(self.center.x+8, self.center.y+30);
        planNumLabel.textAlignment = NSTextAlignmentCenter;
        planNumLabel.textColor = [CommonFunction colorFromHex:0XFFE762FF];
        planNumLabel.text = @"6%";
        planNumLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:planNumLabel];
        
        
        self.center = center;
    }
    
    return self;
}

-(void)configCircle
{
    self.delayLaber = [CAShapeLayer layer];
    self.normalLaber = [CAShapeLayer layer];
    
    CGFloat lineWidth = 17.0f;
    
    UIBezierPath * bez = [UIBezierPath bezierPathWithArcCenter:self.center radius:65 startAngle:degreesToRadians(270) endAngle:degreesToRadians(271) clockwise:NO];
    self.delayLaber.strokeColor = [CommonFunction colorFromHex:0XFFFFCD21].CGColor;//self.lineColor.CGColor;
    self.delayLaber.path = bez.CGPath;
    self.delayLaber.fillColor = nil;
    self.delayLaber.lineJoin = kCALineJoinRound;
    self.delayLaber.lineCap =kCALineCapRound;
    self.delayLaber.lineWidth = lineWidth;
    [self.layer insertSublayer:self.delayLaber above:self.layer];
    
    UIBezierPath * bez2 = [UIBezierPath bezierPathWithArcCenter:self.center radius:85 startAngle:degreesToRadians(270) endAngle:degreesToRadians(271) clockwise:NO];
    self.normalLaber.strokeColor = [CommonFunction colorFromHex:0XFF00F383].CGColor;//self.lineColor.CGColor;
    self.normalLaber.path = bez2.CGPath;
    self.normalLaber.fillColor = nil;
    self.normalLaber.lineJoin = kCALineJoinRound;
    self.normalLaber.lineCap =kCALineCapRound;
    self.normalLaber.lineWidth = lineWidth;
    [self.layer insertSublayer:self.normalLaber above:self.delayLaber];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];//颜色渐变
    gradientLayer.frame = self.frame;
    gradientLayer.colors = @[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ];
    gradientLayer.startPoint = CGPointMake(0,0.5);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.normalLaber;
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];//颜色渐变
    gradientLayer1.frame = self.frame;
    gradientLayer1.colors = @[(__bridge id)[CommonFunction colorFromHex:0XFFAA5FFF].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFE762FF].CGColor ];
    gradientLayer1.startPoint = CGPointMake(0,0.5);
    gradientLayer1.endPoint = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer1 above:self.delayLaber];
    gradientLayer1.mask = self.delayLaber;
}

#pragma mark 动画实现
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd securityProgreesType:(ProductionProgreesType)typ
{
    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    bAni.fromValue = @(0);
    bAni.toValue = @(strokeEnd);
    bAni.duration = 2;//动画持续时间
    bAni.removedOnCompletion = NO;
    
    switch (typ) {
        case ProductionProgreesTypeActual:
            [self.normalLaber pop_addAnimation:bAni forKey:@"NormoalAnimation"];
            [self labelAnimationWithLabel:ActualNumLabel TextNumber:strokeEnd*100];
            break;
            
        case ProductionProgreesTypePlan:
            [self.delayLaber pop_addAnimation:bAni forKey:@"DelayAnimation"];
            break;
            
        default:
            break;
    }
    
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
#pragma mark set方法
-(void)setIsUp:(BOOL)isUp
{
    if (isUp)
    {
        arrow.image = [UIImage imageNamed:@"icon_up.png"];
        planNumLabel.textColor = [CommonFunction colorFromHex:0XFF00EF8C];
    }
    else
    {
        arrow.image = [UIImage imageNamed:@"icon_down.png"];
        planNumLabel.textColor = [CommonFunction colorFromHex:0XFFE762FF];
    }
}

-(void)setPlanNum:(NSInteger)planNum
{
    planNumLabel.text = [NSString stringWithFormat:@"%ld%%",planNum];//@"6%";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
