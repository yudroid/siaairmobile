//
//  RoundProgressView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

#import "RoundProgressView.h"
#import "PoP.h"

@implementation RoundProgressView

-(id)initWithCenter:(CGPoint)   center
             radius:(CGFloat)   radius
         aboveColos:(NSArray *) aboveColos
         belowColos:(NSArray *) belowColos
              start:(CGFloat)   start
                end:(CGFloat)   end
          clockwise:(BOOL)      clockwise
{
    self = [super initWithFrame:CGRectMake(0, 0, radius*2, radius*2)];
    
    if (self)
    {
        //self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示范围
        _aboveColos = [NSArray arrayWithArray:aboveColos];
        _belowColos = [NSArray arrayWithArray:belowColos];
        
        UIImageView *bgImage = [CommonFunction imageView:@"home_circle.png"
                                                   frame:CGRectMake(0, 0, radius*2, radius*2)];
        bgImage.center = self.center;
        [self addSubview:bgImage];
        
        [self configCircle:radius
                     start:start
                       end:end
                 clockwise:clockwise];

        self.center = center;
    }
    
    return self;
}


-(void)configCircle:(CGFloat)   radius
              start:(CGFloat)   start
                end:(CGFloat)   end
          clockwise:(BOOL)      clockwise
{

    self.abnormalLaber  = [CAShapeLayer layer];
    self.normalLaber    = [CAShapeLayer layer];
    self.cancelLaber    = [CAShapeLayer layer];
    
    CGFloat lineWidth   = 17.0f;
    //    CGRect rect = CGRectMake(9, 9, 177-lineWidth/2, 177-lineWidth/2);
    UIBezierPath * bez  = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];//[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];

    self.abnormalLaber.strokeColor  = [CommonFunction colorFromHex:0XFFFFCD21].CGColor;//self.lineColor.CGColor;
    self.abnormalLaber.path         = bez.CGPath;
    self.abnormalLaber.fillColor    = nil;
    self.abnormalLaber.lineJoin     = kCALineJoinRound;
    self.abnormalLaber.lineCap      =kCALineCapRound;
    self.abnormalLaber.lineWidth    = lineWidth;
    [self.layer insertSublayer:self.abnormalLaber above:self.layer];
    
    UIBezierPath * bez1 = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];
    self.cancelLaber.strokeColor    = [CommonFunction colorFromHex:0XFFFE3838].CGColor;//self.lineColor.CGColor;
    self.cancelLaber.path           = bez1.CGPath;
    self.cancelLaber.fillColor      = nil;
    self.cancelLaber.lineJoin       = kCALineJoinRound;
    self.cancelLaber.lineCap        =kCALineCapRound;
    self.cancelLaber.lineWidth      = lineWidth;
    [self.layer insertSublayer:self.cancelLaber
                         below:self.abnormalLaber];
    
    
    UIBezierPath * bez2 = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];//[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    self.normalLaber.strokeColor    = [CommonFunction colorFromHex:0XFF00F383].CGColor;//self.lineColor.CGColor;
    self.normalLaber.path           = bez2.CGPath;
    self.normalLaber.fillColor      = nil;
    self.normalLaber.lineJoin       = kCALineJoinRound;
    self.normalLaber.lineCap        = kCALineCapRound;
    self.normalLaber.lineWidth      = lineWidth;
    
    [self.layer insertSublayer:self.normalLaber
                         above:self.abnormalLaber];
    
    CAGradientLayer *gradientLayer  = [CAGradientLayer layer];//颜色渐变
    gradientLayer.frame             = self.frame;
    gradientLayer.colors            = _aboveColos;//@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ];
    gradientLayer.startPoint        = CGPointMake(0,0.5);
    gradientLayer.endPoint          = CGPointMake(0.5,1);
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask              = self.normalLaber;
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];//颜色渐变
    gradientLayer1.frame            = self.frame;
    gradientLayer1.colors           = _belowColos;//@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ];
    gradientLayer1.startPoint       = CGPointMake(0,0.5);
    gradientLayer1.endPoint         = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer1 above:self.abnormalLaber];
    gradientLayer1.mask             = self.abnormalLaber;

    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];//颜色渐变
    gradientLayer2.frame            = self.frame;
    gradientLayer2.colors           = @[(__bridge id)[CommonFunction colorFromHex:0XFFFE3838].CGColor,
                                        (__bridge id)[CommonFunction colorFromHex:0XFFFF6039].CGColor ];
    gradientLayer2.startPoint       = CGPointMake(0,0.5);
    gradientLayer2.endPoint         = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer2
                         above:self.cancelLaber];
    gradientLayer2.mask             = self.cancelLaber;
}

#pragma mark 动画实现
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd
             withProgressType:(ProgreesType)type
{
    POPBasicAnimation * bAni    = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    bAni.fromValue              = @(0);
    bAni.toValue                = @(strokeEnd);
    bAni.duration               = 2;//动画持续时间
    bAni.removedOnCompletion    = NO;
    
    switch (type) {
        case ProgreesTypeNormal:
            [self.normalLaber pop_addAnimation:bAni
                                        forKey:@"NormoalAnimation"];
            break;
            
        case ProgreesTypeAbnormal:
            [self.abnormalLaber pop_addAnimation:bAni
                                          forKey:@"AbnormoalAnimation"];
            break;
            
        case ProgreesTypeCancel:
            [self.cancelLaber pop_addAnimation:bAni
                                        forKey:@"AbnormoalAnimation"];
            break;
            
        default:
            break;
    }
}

-(void)doAnimation
{
    [self animationWithStrokeEnd:_normalProportion
                withProgressType:ProgreesTypeNormal];
    [self animationWithStrokeEnd:_abnormalProportion
                withProgressType:ProgreesTypeAbnormal];
}

-(id)initWithCenter:(CGPoint)   center
             radius:(CGFloat)   radius
          bigRadius:(CGFloat)   bigRadius
         shapeArray:(NSArray *) shapeArray
          clockwise:(BOOL)      clockwise
{
    self = [super initWithFrame:CGRectMake(0, 0, radius*2, radius*2)];
    
    if (self)
    {
        
        UIImageView *bgImage = [CommonFunction imageView:@"white_circle.png"
                                                   frame:CGRectMake(0, 0, radius*2, radius*2)];
        bgImage.center      = self.center;
        [self addSubview:bgImage];
        self.center         = center;
    }
    
    return self;
}

@end

@implementation SeatUsedRoundProgressView

-(void)configCircle:(CGFloat)   radius
              start:(CGFloat)   start
                end:(CGFloat)   end
          clockwise:(BOOL)      clockwise
{

    self.abnormalLaber  = [CAShapeLayer layer];
    self.normalLaber    = [CAShapeLayer layer];
    self.cancelLaber    = [CAShapeLayer layer];
    self.unusedLaber    = [CAShapeLayer layer];

    CGFloat lineWidth   = 17.0f;
    //    CGRect rect = CGRectMake(9, 9, 177-lineWidth/2, 177-lineWidth/2);

    UIBezierPath * bez3 = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];//[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    self.unusedLaber.strokeColor    = [CommonFunction colorFromHex:0XFF00F383].CGColor;//self.lineColor.CGColor;
    self.unusedLaber.path           = bez3.CGPath;
    self.unusedLaber.fillColor      = nil;
    self.unusedLaber.lineJoin       = kCALineJoinRound;
    self.unusedLaber.lineCap        = kCALineCapRound;
    self.unusedLaber.lineWidth      = lineWidth;

    [self.layer insertSublayer:self.unusedLaber
                         above:self.layer];


    UIBezierPath * bez  = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];//[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];

    self.abnormalLaber.strokeColor  = [CommonFunction colorFromHex:0XFFFFCD21].CGColor;//self.lineColor.CGColor;
    self.abnormalLaber.path         = bez.CGPath;
    self.abnormalLaber.fillColor    = nil;
    self.abnormalLaber.lineJoin     = kCALineJoinRound;
    self.abnormalLaber.lineCap      =kCALineCapRound;
    self.abnormalLaber.lineWidth    = lineWidth;
    [self.layer insertSublayer:self.abnormalLaber above:self.layer];

    UIBezierPath * bez1 = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];
    self.cancelLaber.strokeColor    = [CommonFunction colorFromHex:0XFFFE3838].CGColor;//self.lineColor.CGColor;
    self.cancelLaber.path           = bez1.CGPath;
    self.cancelLaber.fillColor      = nil;
    self.cancelLaber.lineJoin       = kCALineJoinRound;
    self.cancelLaber.lineCap        =kCALineCapRound;
    self.cancelLaber.lineWidth      = lineWidth;
    [self.layer insertSublayer:self.cancelLaber
                         below:self.abnormalLaber];


    UIBezierPath * bez2 = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius-lineWidth/2
                                                     startAngle:degreesToRadians(start)
                                                       endAngle:degreesToRadians(end)
                                                      clockwise:clockwise];//[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    self.normalLaber.strokeColor    = [CommonFunction colorFromHex:0XFF00F383].CGColor;//self.lineColor.CGColor;
    self.normalLaber.path           = bez2.CGPath;
    self.normalLaber.fillColor      = nil;
    self.normalLaber.lineJoin       = kCALineJoinRound;
    self.normalLaber.lineCap        = kCALineCapRound;
    self.normalLaber.lineWidth      = lineWidth;

    [self.layer insertSublayer:self.normalLaber
                         above:self.abnormalLaber];




    CAGradientLayer *gradientLayer  = [CAGradientLayer layer];//颜色渐变
    gradientLayer.frame             = self.frame;
    gradientLayer.colors            = _aboveColos;//@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ];
    gradientLayer.startPoint        = CGPointMake(0,0.5);
    gradientLayer.endPoint          = CGPointMake(0.5,1);
    [self.layer addSublayer:gradientLayer];
    gradientLayer.mask              = self.normalLaber;

    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];//颜色渐变
    gradientLayer1.frame            = self.frame;
    gradientLayer1.colors           = _belowColos;//@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ];
    gradientLayer1.startPoint       = CGPointMake(0,0.5);
    gradientLayer1.endPoint         = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer1 above:self.abnormalLaber];
    gradientLayer1.mask             = self.abnormalLaber;

    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];//颜色渐变
    gradientLayer2.frame            = self.frame;
    gradientLayer2.colors           = @[(__bridge id)[CommonFunction colorFromHex:0XFFbb48eb].CGColor,
                                        (__bridge id)[CommonFunction colorFromHex:0XFFbb48eb].CGColor ];
    gradientLayer2.startPoint       = CGPointMake(0,0.5);
    gradientLayer2.endPoint         = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer2
                         above:self.cancelLaber];
    gradientLayer2.mask             = self.cancelLaber;
    
    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];//颜色渐变
    gradientLayer3.frame            = self.frame;
    gradientLayer3.colors           = @[(__bridge id)[CommonFunction colorFromHex:0XFFf0f0f0].CGColor,
                                        (__bridge id)[CommonFunction colorFromHex:0XFFf0f0f0].CGColor ];
    gradientLayer3.startPoint       = CGPointMake(0,0.5);
    gradientLayer3.endPoint         = CGPointMake(0.5,1);
    [self.layer insertSublayer:gradientLayer3
                         above:self.unusedLaber];
    gradientLayer3.mask             = self.unusedLaber;
}

#pragma mark 动画实现
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd
             withProgressType:(ProgreesType)type
{
    POPBasicAnimation * bAni    = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    bAni.fromValue              = @(0);
    bAni.toValue                = @(strokeEnd);
    bAni.duration               = 2;//动画持续时间
    bAni.removedOnCompletion    = NO;

    switch (type) {
        case ProgreesTypeNormal:
            [self.normalLaber pop_addAnimation:bAni
                                        forKey:@"NormoalAnimation"];
            break;

        case ProgreesTypeAbnormal:
            [self.abnormalLaber pop_addAnimation:bAni
                                          forKey:@"AbnormoalAnimation"];
            break;

        case ProgreesTypeCancel:
            [self.cancelLaber pop_addAnimation:bAni
                                        forKey:@"AbnormoalAnimation"];
            break;

        default:
            [self.unusedLaber pop_addAnimation:bAni
                                        forKey:@"AbnormoalAnimation"];
            break;
    }
}



@end
