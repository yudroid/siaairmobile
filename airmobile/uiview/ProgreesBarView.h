//
//  ProgreesBarView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/20.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POP.h"

@interface ProgreesBarView : UIView
{
    UIView *progressView;
    UIImageView *bg;
}

-(id)initWithCenter:(CGPoint)center size:(CGSize)size direction:(int)direction colors:(NSArray *)colors proportion:(CGFloat)proportion;
-(void)animationWithWidth:(CGFloat)width;
-(void)animationWithStrokeEnd:(CGFloat)strokeEnd;

@end
