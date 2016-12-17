//
//  MonthlyProgressRound.h
//  KaiYa
//
//  Created by WangShiran on 16/3/1.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthlyProgressRound : UIView
{
    CGFloat _normalProportion;
    UILabel *ActualNumLabel;
}

-(id)initWithCenter:(CGPoint)center;
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd;

@property(nonatomic,strong)CAShapeLayer * normalLaber;
@end
