//
//  RoundProgressView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ProgreesTypeAbnormal,
    ProgreesTypeNormal,
    ProgreesTypeCancel,
    
}ProgreesType;

@interface RoundProgressView : UIView
{
    NSArray *_aboveColos;
    NSArray *_belowColos;
    
    CGFloat _normalProportion;
    CGFloat _abnormalProportion;
}

-(id)initWithCenter:(CGPoint)center radius:(CGFloat)radius aboveColos:(NSArray *)aboveColos belowColos:(NSArray *)belowColos start:(CGFloat)start end:(CGFloat)end clockwise:(BOOL)clockwise;

-(void)animationWithStrokeEnd:(CGFloat)strokeEnd withProgressType :(ProgreesType)type;

-(id)initWithCenter:(CGPoint)center radius:(CGFloat)radius bigRadius:(CGFloat)bigRadius shapeArray:(NSArray *)shapeArray clockwise:(BOOL)clockwise;

@property(nonatomic,strong)CAShapeLayer * abnormalLaber;
@property(nonatomic,strong)CAShapeLayer * normalLaber;
@property(nonatomic,strong)CAShapeLayer * cancelLaber;

@end
