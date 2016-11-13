//
//  CommonFunction.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

+(UIView *)addLine:(CGRect)frame color:(UIColor *)color
{
    UIView *line= [[UIView alloc]initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}

+ (UIColor *)colorFromHex:(long)hexColor
{
    long alp = (hexColor >> 24) & 0x000000FF;//透明度
    long red = (hexColor >> 16) & 0x000000FF;
    long green = (hexColor >> 8) & 0x000000FF;
    long blue = hexColor & 0x000000FF;
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f  blue:blue / 255.0f alpha:alp / 255.0f];
}

+(UIImageView *)imageView:(NSString *)imageName frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    
    return imageView;
}

+ (UIImage *)imageWithName:(NSString *)imageName leftCap:(NSInteger)leftCap topCap:(NSInteger)topCap
{
    UIImage *image = [UIImage imageNamed:imageName];
    if([DeviceInfoUtil isSystemVersion5OrLater])
    {
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, topCap, leftCap)];
    }
    else
    {
        image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    }
    return image;
}


+(NSString*)getCNWeekString:(NSInteger)index
{
    NSString *weekStr=@"";
    switch (index) {
        case 1:
            weekStr=@"星期日";
            break;
        case 2:
            weekStr=@"星期一";
            break;
        case 3:
            weekStr=@"星期二";
            break;
        case 4:
            weekStr=@"星期三";
            break;
        case 5:
            weekStr=@"星期四";
            break;
        case 6:
            weekStr=@"星期五";
            break;
        case 7:
            weekStr=@"星期六";
            break;
            
        default:
            break;
    }
    
    return weekStr;
}

+(NSString*)getCNMonthString:(NSInteger)index
{
    NSString *monthStr=@"";
    switch (index) {
        case 1:
            monthStr=@"一月";
            break;
        case 2:
            monthStr=@"二月";
            break;
        case 3:
            monthStr=@"三月";
            break;
        case 4:
            monthStr=@"四月";
            break;
        case 5:
            monthStr=@"五月";
            break;
        case 6:
            monthStr=@"六月";
            break;
        case 7:
            monthStr=@"七月";
            break;
        case 8:
            monthStr=@"八月";
            break;
        case 9:
            monthStr=@"九月";
            break;
        case 10:
            monthStr=@"十月";
            break;
        case 11:
            monthStr=@"十一月";
            break;
        case 12:
            monthStr=@"十二月";
            break;
            
            
        default:
            break;
    }
    
    return monthStr;
}

+(NSString *)dateFormat:(NSDate *)date format:(NSString *)format
{
    if(date==nil){
        date = [NSDate alloc];
        date = [NSDate date];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+(NSString *)nowDate
{
    NSDate *nowDate = [NSDate alloc];
    nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *now = [dateFormatter stringFromDate:nowDate];
    return now;
}

+(CGPoint)MidPointWithPoint1:(CGPoint) p1 Point2:(CGPoint)p2
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

+(float)RandomScaleFrom:(NSInteger)start To:(NSInteger)end Size:(NSInteger)size
{
    return (float)(start + (arc4random() % (end-start+1)))/size;
}

+(NSString*)MD5:(NSString *)str
{
    const char *cStr = [[NSString stringWithFormat:@"%@",str] UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(CGSize)labelSelfAdaptingWithSize:(CGSize)size font:(UIFont *)font labelText:(NSString *)text
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    //根据内容自适应size
    //传入的参数分别为：label矩形的的尺寸界线、文本绘制时的附加选项、文字属性、 文本绘制时的附加选项，包括一些信息，例如如何调整字间距以及缩放，该对象包含的信息将用于文本绘制，该参数可为nil
    CGSize stringSize = [text boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:dic
                                           context:nil].size;
    
    return stringSize;
}

+ (BOOL)ImageHasAlpha:(UIImage *)image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
+ (NSString *)ImageToBase64String:(UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self ImageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UILabel *)addLabelFrame:(CGRect)rect text:(NSString *)text font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment colorFromHex:(long)hexColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.textAlignment = textAlignment;
    label.text = text;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
    label.textColor = [CommonFunction colorFromHex:hexColor];
    return label;
}
@end
