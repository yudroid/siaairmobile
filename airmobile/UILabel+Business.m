//
//  UILabel+Business.m
//  airmobile
//
//  Created by xuesong on 16/11/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UILabel+Business.h"

@implementation UILabel (Business)

-(CGSize)widthThatFits:(CGSize)size
{
    CGRect rect = [self.text boundingRectWithSize:size
                                          options:NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:self.font}
                                          context:nil];
    return rect.size;

}
-(CGFloat)hightThatFits:(CGSize)size
{
    return [self sizeThatFits:size].width;
}

@end
