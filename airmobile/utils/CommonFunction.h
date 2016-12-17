//
//  CommonFunction.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfoUtil.h"

@interface CommonFunction : NSObject

+(UIView *) addLine:(CGRect)frame color:(UIColor *)color;
+(UIColor *) colorFromHex:(long)hexColor;
+(UIImageView *) imageView:(NSString *)imageName frame:(CGRect)frame;
+(UIImage *) imageWithName:(NSString *)imageName leftCap:(NSInteger)leftCap topCap:(NSInteger)topCap;
+(NSString*) getCNWeekString:(NSInteger)index;
+(NSString*) getCNMonthString:(NSInteger)index;
+(NSString *)dateFormat:(NSDate *)date format:(NSString *)format;
+(NSString*) nowDate;
+(float) RandomScaleFrom:(NSInteger)start To:(NSInteger)end Size:(NSInteger)size;
+(NSString*) MD5:(NSString*)str;
+(CGSize) labelSelfAdaptingWithSize:(CGSize)size font:(UIFont *)font labelText:(NSString *)text;
+(BOOL) ImageHasAlpha:(UIImage *)image;
+(NSString *) ImageToBase64String:(UIImage *) image;
+(UILabel *)addLabelFrame:(CGRect)rect text:(NSString *)text font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment colorFromHex:(long)hexColor;


//判断是否为ios10以上版本
+(BOOL) iOSVersion10;
    
@end
