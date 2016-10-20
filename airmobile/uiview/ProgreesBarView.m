//
//  ProgreesBarView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/20.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ProgreesBarView.h"

@implementation ProgreesBarView{
    int direction;
}

-(id)initWithCenter:(CGPoint)center size:(CGSize)size direction:(int)dir colors:(NSArray *)colors proportion:(CGFloat)proportion
{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if(self)
    {
        direction = dir;
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        bg.image = [CommonFunction imageWithName:@"progreesBar_bg.png" leftCap:10 topCap:10];
        [self addSubview:bg];
        
        progressView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        //        progressView.backgroundColor = [UIColor redColor];
        progressView.layer.cornerRadius = size.width/2;
        progressView.layer.masksToBounds =YES;
        [self addSubview:progressView];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.borderWidth = 0;
        gradientLayer.frame = progressView.bounds;
        gradientLayer.colors = colors;
//        gradientLayer.startPoint = CGPointMake(0, 0.5);
//        gradientLayer.endPoint = CGPointMake(0.5, 1);
        [progressView.layer insertSublayer:gradientLayer atIndex:0];
        
        [self animationWithStrokeEnd:proportion];
        
        //        self.layer.cornerRadius = 11;
        //        self.layer.masksToBounds = YES;
        
        self.center = center;
    }
    
    return self;
    
}

-(void)animationWithStrokeEnd:(CGFloat)strokeEnd
{
    
    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    switch (direction) {
        case 1:
            bAni.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, self.frame.size.height)];// 从左到右
            bAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.frame.size.width*strokeEnd, self.frame.size.height)];
            break;
            
        case 2:
            bAni.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];// 从上到下
            bAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*(1-strokeEnd))];
            break;
            
        case 3:
            bAni.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];// 从右到左
            bAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.frame.size.width*(1-strokeEnd), self.frame.size.height)];
            break;
            
        case 4:
            bAni.fromValue = [NSValue valueWithCGRect:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];// 从下到上
            bAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, self.frame.size.height, self.frame.size.width, -self.frame.size.height*strokeEnd)];
            bAni.clampMode = kPOPAnimationClampEnd;
            break;
            
        default:
            break;
    }
    
    bAni.duration = 2;//动画持续时间
    bAni.removedOnCompletion = NO;
    
    [progressView pop_addAnimation:bAni forKey:@"Animation"];
}

-(void)animationWithWidth:(CGFloat)width
{
    bg.frame = CGRectMake(0, 0, width, 22);
    bg.hidden = YES;
    
    
    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    bAni.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 22)];
    bAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, width, 22)];
    bAni.duration = 2;//动画持续时间
    bAni.removedOnCompletion = NO;
    
    [progressView pop_addAnimation:bAni forKey:@"Animation"];
    [bg pop_addAnimation:bAni forKey:@"bgAnimation"];
}

@end
