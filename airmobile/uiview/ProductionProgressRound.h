//
//  ProductionProgressRound.h
//  KaiYa
//
//  Created by WangShiran on 16/2/29.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ProductionProgreesTypePlan,
    ProductionProgreesTypeActual,
    
}ProductionProgreesType;

@interface ProductionProgressRound : UIView
{
    NSArray *_aboveColos;
    NSArray *_belowColos;
    
    CGFloat _normalProportion;
    CGFloat _abnormalProportion;
    
    UILabel *ActualNumLabel;
    
    UIImageView *arrow;
    UILabel *planNumLabel;
}

-(id)initWithCenter:(CGPoint)center;
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd securityProgreesType:(ProductionProgreesType)typ;

@property(nonatomic,strong)CAShapeLayer * delayLaber;
@property(nonatomic,strong)CAShapeLayer * normalLaber;
@property(nonatomic,assign)BOOL isUp;
@property(nonatomic,assign)NSInteger planNum;


@end
